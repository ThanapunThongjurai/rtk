import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rtk/DataController.dart';
import 'package:rtk/pages/GetIP.dart';
import 'package:rtk/pages/HomePage.dart';

import 'ConfigController.dart';

void main() {
  runApp(MyApp());
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
    SecondPage(),
    ThirdPage(),
    HomePage(),
    HomePage(),
    HomePage(),
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
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Second',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Third',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Third',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Third',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Third',
            ),


          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('First Page'),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Second Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Third Page'),
    );
  }
}
