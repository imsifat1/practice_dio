import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_dio/Cart/AddToCartService.dart';
import 'package:practice_dio/Cart/CartToContentService.dart';
import 'package:practice_dio/Cart/CheckOutService.dart';
import 'package:practice_dio/Cart/cart_list_page.dart';
import 'package:practice_dio/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key? key}) : super(key: key);
  var cart = CartToContentService();

  var addCart = AddToCartService();

  Session session = Session();

  String _addToCartStatus = "";
  String _cartListStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Add To Cart Status: \n" + _addToCartStatus),
              SizedBox(
                height: 10,
              ),
              Text("Cart List Status: \n" + _cartListStatus),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.amber,
                  child: Text("Add To Cart"),
                  onPressed: () {
                    // _addToCartStatus = addCart.addToCartStatus;
                    // session.get(
                    //     "https://www.moharaj.com.bd/_public/addToCart?quantity=5&slug=cotton-fleece-hoodie-for-men-tekka-8486&variant_id=24469");

                    addCart.getData();
                  }),
              MaterialButton(
                  color: Colors.green,
                  child: Text("Cart List"),
                  onPressed: () {
                    // _cartListStatus = cart.cartListStatus;
                    // session.get(
                    //     "https://www.moharaj.com.bd/_public/cartToContent");

                    // cart.getCartContent();
                    Get.to(() => CartListPage());
                    // addCart.getCartContent();
                  }),
              MaterialButton(
                  color: Colors.cyan,
                  child: Text("Check Out"),
                  onPressed: () {
                    CheckOutService.getCheckOut();
                  }),
              MaterialButton(
                  color: Colors.red,
                  child: Text("Log Out"),
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove("email");
                    sharedPreferences.remove("UserName");
                    sharedPreferences.remove("UserEmail");
                    sharedPreferences.remove("MobileNumber");
                    sharedPreferences.remove("Address");
                    sharedPreferences.remove("id");

                    Get.to(Login());
                  })
            ]),
      ),
    );
  }
}
