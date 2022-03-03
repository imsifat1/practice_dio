import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_dio/NewProducts/NewArrival.dart';
import 'package:practice_dio/NewProducts/NewCollectionProductModel.dart';

/**
 * This is a Service Class. 
 * This Service Class is used for New COllection Product.
 * 
 */

class NewCollectionProductService {
  static var product;
  static Future<NewCollectionProductModel>
      getNewCollectionProductService() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.0.116/api/new/collection/products?page=$pageNumber"));
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decode = jsonDecode(response.body);
        product = NewCollectionProductModel.fromJson(decode);
        return product;
      } else {
        return product;
      }
    } catch (error) {
      print(error);
      throw Exception();
    }
  }
}
