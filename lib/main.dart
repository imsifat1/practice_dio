import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_dio/Controller.dart';
import 'package:practice_dio/Design1/WidgetHomePage.dart';
import 'package:practice_dio/Design2/Design2HomePage.dart';
import 'package:practice_dio/Design3/constants.dart';
import 'package:practice_dio/Design3/screens/home/home.dart';

import 'package:practice_dio/HomePage.dart';
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
  runApp(GetMaterialApp(home: HomePage()));
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      home: Design2HomePage(),
    );
  }
}

class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: HomeScreen(),
    );
  }
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

class MyApp2 extends StatelessWidget {
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
