import 'package:get/get.dart';
import 'package:practice_dio/Cart/AddToCartService.dart';
import 'package:practice_dio/Cart/CartToContentModel.dart';

class CartController extends GetxController {
  late Future<CartToContentModel?> getData;
  AddToCartService addToCartService = AddToCartService();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData = addToCartService.getCartContent();
  }
}
