import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_dio/Controller.dart';
import 'package:practice_dio/Login/Login.dart';
import 'package:practice_dio/Model.dart';
import 'package:practice_dio/Slider/SliderPage.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(GetMaterialApp(home: TestHomePage()));
}

RxInt counter = 0.obs;

increment() {
  counter++;
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Home Page")),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        SliderPage(),
        SizedBox(
          height: 50,
        ),
        Obx(() => Text("Counter: " + counter.toString())),
        MaterialButton(
            color: Colors.amber,
            child: Text("Increment"),
            onPressed: () {
              increment();
            })
      ]),
    );
  }
}

class MyApp extends StatelessWidget {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Practice Dio Package")),
      body: FutureBuilder<List<Model>>(
          future: controller.getData,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                  );
                });
          }),
    );
  }
}
