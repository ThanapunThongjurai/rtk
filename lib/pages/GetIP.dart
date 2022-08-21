import 'dart:collection';
import 'dart:io';

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

  Map<String, String> listIp = HashMap();

  //Logic
  void setIpAndPort() {}

  void nextPage() {
    getDataFormControllerGetIP.ip.value = ip.text;
    getDataFormControllerGetIP.port.value = port.text;
    getDataFormControllerData.connectServer(getDataFormControllerGetIP.ip.value,
        int.parse(getDataFormControllerGetIP.port.value));

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
            flex: 1,
            child: TextButton(
                onPressed: () {
                  nextPage();
                },
                child: Text("OK"))),
      ],
    );
  }

  Future<void> testScan() async {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 9000)
        .then((RawDatagramSocket socket) {
      print('Datagram socket ready to receive');
      print('${socket.address.address}:${socket.port}');

      socket.listen((RawSocketEvent e) {
        Datagram? d = socket.receive();
        if (d == null) return;

        String message = new String.fromCharCodes(d.data).trim();
        print('Datagram from ${d.address.address}:${d.port}: ${message}');
        setState(() {
          listIp[d.address.address] = d.address.address ;
        });
      });
    });
  }

  Widget displayIpScan() {
    var keys = listIp.keys.toList();
    //String key = values.keys.elementAt(index);
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: listIp.length,
        itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(

              onTap: (){
                getDataFormControllerGetIP.ip.value = listIp[keys[index]]!;
                getDataFormControllerGetIP.port.value = port.text;
                getDataFormControllerData.connectServer(getDataFormControllerGetIP.ip.value,
                    int.parse(getDataFormControllerGetIP.port.value));

                Get.to(() => HomePage());

              },
              title: Text(listIp[keys[index]]!),
            )));
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
          displayIpScan(),
        ],
      ),
    );
  }
}
