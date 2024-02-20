import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learning_sqflite/models/learning_model.dart';
import 'package:learning_sqflite/pages/favorite_page_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePageController extends GetxController {
  Future<List<LearningModel>> fetchData() async {
    Database? database;
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_learning";
    database = await openDatabase(path);
    final data = await database.query("learning");
    List<LearningModel> learning =
        data.map((e) => LearningModel.fromJson(e)).toList();
    return learning;
  }

  Future<void> deleteFromFavorite(int id) async {
    Database? database;
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_learning";
    database = await openDatabase(path);
    await database.delete("learning", where: "id = ?", whereArgs: [id]);
    Get.off(FavoritePageView(), transition: Transition.noTransition);
  }
}
