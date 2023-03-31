import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rtk/DataController.dart';
import 'package:rtk/datamodel/GNGSTmodel.dart';
import 'package:rtk/lib/NMEA0183.dart';
import 'package:rtk/pages/getIP.dart';
import 'package:rtk/widget/NavDrawer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../config.dart';
import '../ConfigController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Install
  final getDataFormControllerGetIP = Get.find<ConfigController>();
  final getDataFormControllerData = Get.find<DataController>();

  late String ip = getDataFormControllerGetIP.ip.value;
  late String port = getDataFormControllerGetIP.port.value;
  Socket? _socket;

  late String GNGGA = "";
  late String GNGST = "";
  late String GNRMC = "";
  late String RUN = "";

  GNGSTmodel gngsTmodel = new GNGSTmodel();


  //Logic


  //Widget

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: Obx(()=>Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(getDataFormControllerData.GNGGA.value),
              ),
              Container(
                child: Text(getDataFormControllerData.GNGST.value),
              ),
              Container(
                child: Text(getDataFormControllerData.GNRMC.value),
              ),
              Container(
                child: Text(getDataFormControllerData.RUN.value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
