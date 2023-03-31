import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rtk/DataController.dart';
import 'package:rtk/pages/GetIP.dart';
import 'package:rtk/pages/HomePage.dart';
import 'package:rtk/pages/logPage.dart';
import 'package:rtk/pages/mapPage.dart';
import 'package:rtk/pages/sendConfigPage.dart';

import 'ConfigController.dart';

void main() {
  runApp(MyApp2());
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
        primarySwatch: Colors.red,
      ),
      home: const GetIPDevices(),
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {


  int _currentIndex = 0;
  final List<Widget> _pages = [
    const GetIPDevices(),
    const HomePage(),
    const LogPage(),
    const sendConfigPage(),
    const MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final getDataFormControllerGetIP = Get.put(ConfigController());
    final getDataFormControllerData = Get.put(DataController());
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.towerBroadcast),
              label: 'IP',
            ),
            BottomNavigationBarItem(
              icon:  Icon(FontAwesomeIcons.arrowsToEye),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.pager),
              label: 'Log',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.terminal),
              label: 'Terminal',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.map),
              label: 'Map',
            ),


          ],
        ),
      ),
    );
  }
}