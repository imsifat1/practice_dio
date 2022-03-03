import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_dio/Cart/CartToContentModel.dart';
import 'package:practice_dio/Cart/practice_model.dart';

Session session = Session();

class AddToCartService {
  String addToCartStatus = "";
  var cartListStatus = "";
  Future<void> getData() async {
    var response = await session.get(
        "https://www.moharaj.com.bd/_public/addToCart?quantity=5&slug=unstitched-indian-georgette-four-piece-8493&variant_id=24469");

    if (response.statusCode == 200) {
      print(response.body);
      addToCartStatus = response.body;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<CartToContentModel?> getCartContent() async {
    http.Response response =
        await session.get("https://www.moharaj.com.bd/_public/cartToContent");

    CartToContentModel? model;
    if (response.statusCode == 200) {
      // print(response.body);
      var pmodel = PracticeModel.fromJson(response.body);
      print(pmodel);
      // Map<String, dynamic> decode = json.decode(response.body);
      model = CartToContentModel.fromJson(response.body);
      return model;
      // cartListStatus = response.body;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<void> checkout() async {
    var response = await session.post(
        "https://www.moharaj.com.bd/api/_public/checkout?mobile_no=12345678928&name=tekashi68&address=Wari&city=1&sub_city=320&shipping_cost=120&p_m=cash",
        "");

    print(session.headers);
    if (response.statusCode == 200) {
      print(response.body);
      cartListStatus = response.body;
    } else {
      print(response.reasonPhrase);
    }
  }
}

class Session {
  Map<String, String> headers = {
    'Authorization':
        'Bearer 1643548163\$2y\$10\$0.s7NDaUuUDwgWjpBl7VpOpwWgwAfrjZfhdrTaC3Isf7Dfo/MPdXO1643548163',
  };

  Future<dynamic> get(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (!headers.containsKey("cookie")) updateCookie(response);
    return response;
  }

  Future<dynamic> post(String url, dynamic data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    if (!headers.containsKey("cookie")) updateCookie(response);
    return response;
  }

  // void updateCookie(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   print(rawCookie);
  //   if (rawCookie != null && headers.isEmpty) {
  //     int index = rawCookie.indexOf(';');
  //     headers['Cookie'] =
  //         (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }

  void updateCookie(http.Response response) {
    print(response.headers);
    final sessionKey = response.headers['set-cookie']
        ?.split('laravel_session=')[1]
        .split(';')[0];
    if (sessionKey != null) headers['cookie'] = 'laravel_session=$sessionKey';
  }
}
