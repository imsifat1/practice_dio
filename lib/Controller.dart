import 'package:get/get.dart';
import 'package:practice_dio/Model.dart';
import 'package:practice_dio/Service.dart';

class Controller extends GetxController {
  late Future<List<Model>> getData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData = Service.getData();
  }
}
