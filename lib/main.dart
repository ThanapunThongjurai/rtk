import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rtk/DataController.dart';
import 'package:rtk/pages/GetIP.dart';
import 'package:rtk/pages/HomePage.dart';

import 'ConfigController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final getDataFormControllerGetIP = Get.put(ConfigController());
    final getDataFormControllerData = Get.put(DataController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const GetIPDevices(),
    );
  }
}
