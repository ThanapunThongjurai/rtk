import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rtk/DataController.dart';
import 'package:rtk/datamodel/GNGGAmodel.dart';
import 'package:rtk/datamodel/GNGSTmodel.dart';
import 'package:rtk/datamodel/GNRMCmodel.dart';
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

  late GNGGAmodel GNGGA = getDataFormControllerData.gngga.value as GNGGAmodel;
  late GNGSTmodel GNGST = getDataFormControllerData.gngst.value as GNGSTmodel;
  late GNRMCmodel GNRMC = getDataFormControllerData.gnrmc.value as GNRMCmodel;
  late String RUN = "";

  GNGSTmodel gngsTmodel = new GNGSTmodel();

  //Logic

  //Widget

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      // update the GNGGA value
      setState(() {
        GNGGA = getDataFormControllerData.gngga.value as GNGGAmodel;
        GNGST = getDataFormControllerData.gngst.value as GNGSTmodel;
        GNRMC = getDataFormControllerData.gnrmc.value as GNRMCmodel;
      });
    });
  }

  TableRow TableList(String Header, String Data) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(Header),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(Data),
        ),
      ],
    );
  }

  TableRow TableList2(String Header, String Data, String Data2) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(Header),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(Data + " " + Data2),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(GNGGA.toString());
    return Scaffold(
      //drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            // add padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Table(
                  border: TableBorder.all(width: 1.0, color: Colors.grey),
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    // first column takes 2/3 of available width
                    1: FlexColumnWidth(1),
                    // second column takes 1/3 of available width
                  },
                  children: [
                    TableList(
                      "Timestamp",
                      getDataFormControllerData.gngga.value.utc == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.utc!,
                    ),
                    TableList2(
                      "Latitude",
                      getDataFormControllerData.gngga.value.lat == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.utc!,
                      getDataFormControllerData.gngga.value.latDir == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.latDir!,
                    ),
                    TableList2(
                      "Longitude",
                      getDataFormControllerData.gngga.value.lon == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.lon!,
                      getDataFormControllerData.gngga.value.lonDir == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.lonDir!,
                    ),
                    TableList(
                      "GPS quality indicator\n(0 = invalid, 1 = GPS fix, 2 = Differential GPS fix)",
                      getDataFormControllerData.gngga.value.quality == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.quality!,
                    ),
                    TableList(
                      "Number of satellites used for the fix",
                      getDataFormControllerData.gngga.value.sats == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.sats!,
                    ),
                    TableList(
                      "Horizontal dilution of precision (HDOP)",
                      getDataFormControllerData.gngga.value.hdop == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.hdop!,
                    ),
                    TableList2(
                      "Altitude of the fix",
                      getDataFormControllerData.gngga.value.altitude == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.altitude!,
                      getDataFormControllerData.gngga.value.altitudeUnit == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.altitudeUnit!,
                    ),
                    TableList2(
                      "Height of the geoid",
                      getDataFormControllerData.gngga.value.geoid == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.geoid!,
                      getDataFormControllerData.gngga.value.geoiduUints == null
                          ? "null"
                          : getDataFormControllerData.gngga.value.geoiduUints!,
                    ),
                    TableList(
                      "Status\n(A = valid, V = invalid).",
                      getDataFormControllerData.gnrmc.value.posStatus == null
                          ? "null"
                          : getDataFormControllerData.gnrmc.value.posStatus!,
                    ),
                    TableList(
                      "Speed over ground in knots.",
                      getDataFormControllerData.gnrmc.value.speedKn == null
                          ? "null"
                          : getDataFormControllerData.gnrmc.value.speedKn!,
                    ),
                    TableList(
                      "Date of the fix",
                      getDataFormControllerData.gnrmc.value.date == null
                          ? "null"
                          : getDataFormControllerData.gnrmc.value.date!,
                    ),
                    TableList(
                      "Mode indicator\n(D = Differential GPS mode).",
                      getDataFormControllerData.gnrmc.value.modeInd == null
                          ? "null"
                          : getDataFormControllerData.gnrmc.value.modeInd!,
                    ),
                    TableList(
                      "Navigation receiver warning(V = warning).",
                      getDataFormControllerData.gnrmc.value.Navigationreceiverwarning == null
                          ? "null"
                          : getDataFormControllerData.gnrmc.value.Navigationreceiverwarning!,
                    ),
                    // add more rows as needed
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Text(
                    (getDataFormControllerData.gngga.value as GNGGAmodel)
                        .toString()
                        .replaceAll(',', ',\n')
                        .replaceAll('{', ',\n'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Text(
                    (getDataFormControllerData.gngst.value as GNGSTmodel)
                        .toString()
                        .replaceAll(',', ',\n')
                        .replaceAll('{', ',\n'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Text(
                    (getDataFormControllerData.gnrmc.value as GNRMCmodel)
                        .toString()
                        .replaceAll(',', ',\n')
                        .replaceAll('{', ',\n'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Text(getDataFormControllerData.RUN.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
