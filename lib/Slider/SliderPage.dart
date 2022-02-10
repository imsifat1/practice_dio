import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_dio/Slider/SliderModel.dart';
import 'package:practice_dio/Slider/SliderPageController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// var currentIndex = 0.obs;
String prefix_url = "https://moharaj.com.bd/public/storage/";
RxInt currentIndex = 0.obs;

class SliderPage extends StatelessWidget {
  SliderPageController sliderPageController = Get.put(SliderPageController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: FutureBuilder<SliderModel>(
          future: sliderPageController.getData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    // shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.sliders.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      // print(prefix_url +
                      //     snapshot.data!.sliders[index].image.toString());
                      var image =
                          snapshot.data!.sliders[index].image.toString();
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            prefix_url + image,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : Center(
                                      child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ));
                              // : LinearProgressIndicator();
                            },
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        currentIndex = index.obs;
                        print(currentIndex);
                        return currentIndex;
                      },
                      height: MediaQuery.of(context).size.height / 5,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex: currentIndex.toInt(),
                            count: snapshot.data!.sliders.length,
                            effect: WormEffect(
                                dotWidth: 5,
                                dotHeight: 5,
                                dotColor: Colors.white,
                                activeDotColor: Colors.black),
                          ),
                        )),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}
