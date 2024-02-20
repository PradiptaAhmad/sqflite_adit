import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:learning_sqflite/controller/favorite_controller.dart';
import 'package:learning_sqflite/models/learning_model.dart';

class FavoritePageView extends StatelessWidget {
  const FavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritePageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<LearningModel>>(
                future: controller.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<LearningModel> learns = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: learns.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        LearningModel learn = learns[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Card(
                            child: ListTile(
                                title: Text(learn.title!),
                                subtitle: Text(learn.duration!),
                                leading: Image.network(learn.images!),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.deleteFromFavorite(learn.id!);
                                   
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
