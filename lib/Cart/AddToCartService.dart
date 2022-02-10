import 'dart:convert';

import 'package:http/http.dart' as http;

class AddToCartService {
  String addToCartStatus = "";
  Future<void> getData() async {
    var response = await http.get(Uri.parse(
        "https://www.moharaj.com.bd/_public/addToCart?quantity=5&slug=cotton-fleece-hoodie-for-men-tekka-8486&variant_id=24469"));

    if (response.statusCode == 200) {
      print(response.body);
      addToCartStatus = response.body;
    } else {
      print(response.reasonPhrase);
    }
  }
}
