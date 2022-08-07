import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rtk/pages/GetIP.dart';
import 'package:rtk/pages/HomePage.dart';
import 'package:rtk/pages/logPage.dart';
import 'package:rtk/pages/mapPage.dart';

class NavDrawerWidget extends StatefulWidget {
  const NavDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavDrawerWidget> createState() => _NavDrawerWidgetState();
}

class _NavDrawerWidgetState extends State<NavDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(FontAwesomeIcons.btc),
                title: Text("IPdevices"),
                onTap: ()=>Get.off(()=>GetIPDevices()),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.home),
                title: Text("HomePage"),
                onTap: ()=>Get.off(()=>HomePage()),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.btc),
                title: Text("LogPage"),
                onTap: ()=>Get.off(()=>LogPage()),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.map),
                title: Text("MapPage"),
                onTap: ()=>Get.off(()=>MapPage()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
