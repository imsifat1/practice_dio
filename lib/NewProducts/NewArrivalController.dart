import 'package:get/get.dart';

import 'package:practice_dio/NewProducts/NewCollectionProductModel.dart';
import 'package:practice_dio/NewProducts/NewCollectionProductService.dart';

class NewArrivalController extends GetxController {
  late Future<NewCollectionProductModel> newCollectionProduct;
  @override
  void onInit() {
    super.onInit();
    newCollectionProduct =
        NewCollectionProductService.getNewCollectionProductService();
  }
}
