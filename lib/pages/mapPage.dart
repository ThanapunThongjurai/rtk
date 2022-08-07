import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rtk/datamodel/GNGGAmodel.dart';

import '../DataController.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final getDataFormControllerData = Get.find<DataController>();
  Completer<GoogleMapController> Gcontroller = Completer();
  Set<Marker> point = {};

  double lat = 0;
  double lng = 0;

  // List<Marker> test  = new Marker(markerId: markerId);
  // var test2 = Marker(markerId: MarkerId("marker1"),position: LatLng(13.706440628333333, 100.39416788333334));
  // test.add(test);

  @override
  void initState() {
    super.initState();
    GNGGAmodel test = getDataFormControllerData.gngga.value;
    lat = double.parse(test.lat!);
    lng = double.parse(test.lon!);
  }

  @override
  Widget build(BuildContext context) {
    point.add(Marker(markerId: MarkerId("marker1"), position: LatLng(lat, lng)));

    return Scaffold(
      body: Container(
        child: GoogleMap(
          markers: point,
          initialCameraPosition:
              CameraPosition(target: LatLng(lat, lng), zoom: 15),
          mapType: MapType.normal,
          onMapCreated: (controller) {
            Gcontroller.complete(controller);
          },
        ),
      ),
    );
  }
}