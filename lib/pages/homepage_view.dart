import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:learning_sqflite/controller/homepage_controller.dart';
import 'package:learning_sqflite/models/learning_model.dart';
import 'package:learning_sqflite/pages/favorite_page_view.dart';

class HomePageView extends StatelessWidget {
  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomepageController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Learning",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(FavoritePageView());
              },
              icon: Icon(Icons.favorite_outline))
        ],
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
                                    controller.addToFavorite(LearningModel(
                                        id: learn.id,
                                        title: learn.title,
                                        instructor: learn.instructor,
                                        price: learn.price,
                                        rating: learn.rating,
                                        images: learn.images,
                                        lessons: learn.lessons,
                                        duration: learn.duration,
                                        description: learn.description,
                                        createdAt: learn.createdAt,
                                        updatedAt: learn.updatedAt));
                                  },
                                  icon: Icon(Icons.favorite_border_outlined),
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
