import 'package:flutter/material.dart';
import 'package:practice_dio/Cart/AddToCartService.dart';
import 'package:practice_dio/Cart/CartToContentModel.dart';
import 'package:practice_dio/Cart/cart_controller.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  late Future<CartToContentModel?> getData;
  AddToCartService addToCartService = AddToCartService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData = addToCartService.getCartContent();
  }

  @override
  Widget build(BuildContext context) {
    CartController cartController = CartController();
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Container(
        child: FutureBuilder<CartToContentModel?>(
            future: getData,
            builder: ((context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.cartContent?.length,
                  itemBuilder: ((context, index) {
                    var data = snapshot.data!.cartContent![index];
                    print(data.name);
                    return ListTile(
                      title: Text(data.name.toString()),
                    );
                  }));
            })),
      ),
    );
  }
}
