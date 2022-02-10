import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:practice_dio/HomePage.dart';
import 'package:practice_dio/Login/Login.dart';
import 'package:practice_dio/Login/LoginModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class LoginService {
  static Future<LoginModel> loginProcess() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    // Print cookies
    print(cookieJar.loadForRequest(
        Uri.parse("https://www.moharaj.com.bd//api/_public/userToLogin")));
    // second request with the cookie
    var model;
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      var response =
          await dio.post("https://www.moharaj.com.bd//api/_public/userToLogin",
              data: ({
                'email_or_mobile_number': emailTextController.text,
                'password': passwordTextController.text
              }));
      // var response = await http.post(
      //     Uri.parse("https://www.moharaj.com.bd//api/_public/userToLogin"),
      //     body: ({
      //       'email_or_mobile_number': emailTextController.text,
      //       'password': passwordTextController.text
      //     }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        Get.to(HomePage());
        var decode = json.decode(response.data);

        ///--------------------------------------------------------
        ///                   User Data Save Here
        /// -------------------------------------------------------

        print("So this is your madafacking name: " + decode["user"]["name"]);

        sharedPreferences.setString("UserName", decode["user"]["name"]);
        sharedPreferences.setString("UserEmail", decode["user"]["email"]);
        sharedPreferences.setString(
            "MobileNumber", decode["user"]["mobile_no"]);
        sharedPreferences.setString("Address", decode["user"]["address"]);
        sharedPreferences.setInt("id", decode["user"]["id"]);
        sharedPreferences.setString("token", decode["user"]["api_token"]);

        ///--------------------------------------------------------
        ///                   User Data Save Here
        /// -------------------------------------------------------
        model = LoginModel.fromJson(decode);
        return model;
      } else {
        Get.snackbar("Invalid Credentials", "Incorrect Username or password");
        print("invalid credentials");
      }

      return model;
    } else {
      throw Exception();
    }
  }
}
