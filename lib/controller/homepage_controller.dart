import 'dart:convert';
import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learning_sqflite/models/learning_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  Future<void> initDatabase() async {
    Database? database;
    String db_name = "db_learning";
    int db_version = 1;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + db_name;

    if (database == null) {
      database = await openDatabase(path, version: db_version,
          onCreate: (Database db, int version) async {
        print("Creating table");
        await db.execute('''
      CREATE TABLE IF NOT EXISTS learning (
        id INTEGER PRIMARY KEY,
        title TEXT,
        instructor TEXT,
        price INTEGER,
        rating REAL,
        images TEXT,
        lessons TEXT,
        duration TEXT,
        description TEXT,
        created_at TEXT,  
        updated_at TEXT
      )
    ''');
        print("done create table");
      });
    }
  }

  Future<List<LearningModel>> fetchData() async {
    var headers = {"Accept": "Application/json"};
    var response = await http.get(
        Uri.parse(
          "https://zell-learning.000webhostapp.com/api/learning",
        ),
        headers: headers);
    List<dynamic> jsonData = json.decode(response.body)["data"];
    List<LearningModel> data =
        jsonData.map((e) => LearningModel.fromJson(e)).toList();
    return data;
  }

  Future<void> addToFavorite(LearningModel learningModel) async {
    Database? database;
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_learning";
    database = await openDatabase(path);
    print(database);
    await database.insert("learning", learningModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  void onReady() {
    initDatabase();
    print("berhasil membuat database");
    super.onReady();
  }
}
