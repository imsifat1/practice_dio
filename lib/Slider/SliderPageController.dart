import 'package:get/get.dart';
import 'package:practice_dio/Slider/SliderModel.dart';
import 'package:practice_dio/Slider/SliderService.dart';

class SliderPageController extends GetxController {
  // RxInt currentIndex = 0.obs;
  late Future<SliderModel> getData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData = SliderService.getSliderData();
  }
}
