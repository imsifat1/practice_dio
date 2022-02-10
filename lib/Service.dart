import 'dart:convert';

import 'package:practice_dio/Model.dart';
import 'package:dio/dio.dart';

class Service {
  static Future<List<Model>> getData() async {
    var dio = Dio();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    print(response);
    List<Model> model;
    if (response.statusCode == 200) {
      List decode = response.data;

      model = decode.map((e) => Model.fromJson(e)).toList();
      return model;
    } else {
      throw Exception();
    }
  }
}
