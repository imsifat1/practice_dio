import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:practice_dio/Slider/SliderModel.dart';

class SliderService {
  static Future<SliderModel> getSliderData() async {
    var dio = Dio();
    final response = await dio.get("https://www.moharaj.com.bd/_public/slider");

    // print(response.body);
    var getdata;
    if (response.statusCode == 200 || response.statusCode == 201) {
      final decode = response.data;
      getdata = SliderModel.fromJson(decode);
      return getdata;
    } else {
      return getdata;
    }
  }
}
