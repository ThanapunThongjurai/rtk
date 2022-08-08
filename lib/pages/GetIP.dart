import 'package:flutter/material.dart';
import 'package:network_tools/network_tools.dart';
import 'package:get/get.dart';
import 'package:rtk/ConfigController.dart';
import 'package:rtk/pages/HomePage.dart';

import '../DataController.dart';
import '../config.dart';
import '../widget/NavDrawer.dart';

class GetIPDevices extends StatefulWidget {
  const GetIPDevices({Key? key}) : super(key: key);

  @override
  State<GetIPDevices> createState() => _GetIPDevicesState();
}

class _GetIPDevicesState extends State<GetIPDevices> {
  TextEditingController ip = new TextEditingController(text: "192.168.1.150");
  TextEditingController port = new TextEditingController(text: "9000");


  final getDataFormControllerGetIP = Get.find<ConfigController>();
  final getDataFormControllerData = Get.find<DataController>();

  //Logic
  void setIpAndPort() {}

  void nextPage(){
    getDataFormControllerGetIP.ip.value = ip.text;
    getDataFormControllerGetIP.port.value = port.text;
    getDataFormControllerData.connectServer(getDataFormControllerGetIP.ip.value,int.parse(getDataFormControllerGetIP.port.value));

    Get.to(() => HomePage());
  }

  //Widget
  Widget manualIp() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: TextFormField(
              controller: ip,
              decoration: InputDecoration(hintText: "IP"),
            )),
        Expanded(
            flex: 1,
            child: TextFormField(
              controller: port,
              decoration: InputDecoration(hintText: "PORT"),
            )),
        Expanded(
            flex: 1, child: TextButton(onPressed: () {nextPage();}, child: Text("OK"))),
      ],
    );
  }

  Future<void> testScan() async {

  }

  @override
  void initState() {
    testScan();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerWidget(),
      appBar: AppBar(
        title: const Text("SELECT IP TO CONNECT"),
      ),
      body: Column(
        children: <Widget>[
          manualIp(),
        ],
      ),
    );
  }
}
