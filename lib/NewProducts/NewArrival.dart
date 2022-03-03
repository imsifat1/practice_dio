import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_dio/NewProducts/NewArrivalController.dart';
import 'package:practice_dio/NewProducts/NewCollectionProductModel.dart';
import 'package:practice_dio/NewProducts/NewCollectionProductService.dart';
import 'package:practice_dio/NewProducts/Products.dart';

//------------------------------------------------------------
//        this widget is for Upcoming categories
//------------------------------------------------------------

class NewArrival extends StatefulWidget {
  @override
  State<NewArrival> createState() => _NewArrivalState();
}

var pageNumber = 1;
List<int> productArray = [];
bool isLoadingVertical = false;

class _NewArrivalState extends State<NewArrival> {
  NewArrivalController newArrivalController = Get.put(NewArrivalController());
  late Future<NewCollectionProductModel> getData;
  List p = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getData = NewCollectionProductService.getNewCollectionProductService();

    super.initState();
    NewCollectionProductService.getNewCollectionProductService()
        .then((value) {});
    scrollController.addListener(() {
      print(scrollController.position.pixels);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          addMore();
          pageNumber++;
          getData =
              NewCollectionProductService.getNewCollectionProductService();
        });
        // collectionOfData();

        print(pageNumber);
      }
    });
  }

  Future addMore() async {
    await new Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoadingVertical = true;
    });

    productArray.addAll(List.generate(10, (index) => productArray.length + 10));

    setState(() {
      isLoadingVertical = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: collectionOfData()),
    );
  }

  collectionOfData() {
    return FutureBuilder<NewCollectionProductModel>(
        future: getData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                controller: scrollController,
                // physics: NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: productArray.length,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2),
                itemBuilder: (context, int index) {
                  var product = snapshot.data!.data[index];
                  //slug = product.slug;
                  String image = product.productImage[0].prefixUrl.toString() +
                      product.productImage[0].productImage.toString();

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 300,
                      width: 200,
                      child: Products(
                        image,
                        product.name,
                        product.price,
                        product.discount,
                        product.salePrice,
                        product.id,
                        context,
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
