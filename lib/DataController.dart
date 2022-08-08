import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:rtk/datamodel/GNGGAmodel.dart';
import 'package:rtk/datamodel/GNGSTmodel.dart';
import 'package:rtk/datamodel/GNRMCmodel.dart';

import 'lib/NMEA0183.dart';

class DataController extends GetxController {
  RxString GNGGA = "".obs;
  RxString GNGST = "".obs;
  RxString GNRMC = "".obs;
  RxString RUN = "".obs;
  Rx<GNGSTmodel> gngst = GNGSTmodel().obs;
  Rx<GNRMCmodel> gnrmc = GNRMCmodel().obs;
  Rx<GNGGAmodel> gngga = GNGGAmodel().obs;

  RxString latGNGGA = "".obs;
  RxString lonGNGGA = "".obs;

  Socket? _socket;

  Future<void> connectServer(String ip,int port) async {
    _socket?.done;
    _socket?.close();

    try {
      print("Connectins...");
      _socket = await Socket.connect(ip, port);
      _socket?.listen((event) {
        //print(utf8.decode(event)+"\n\n");
        List<String> decode = NMEA().SplitData(utf8.decode(event));
        for (var element in decode) {
            if (element.startsWith("\$GNGGA")) {
              GNGGA.value = element;
              GNGGAmodel temp = NMEA().GNGGAprase(element);
              if(temp.lat == null)
                temp.lat = "0";
              if(temp.lon == null)
                temp.lon = "0";
              gngga.value = temp;
            }
            else if (element.startsWith("\$GNGST")) {
              GNGST.value = element;
              gngst.value = NMEA().GNGSTprase(element);
            }
            else if (element.startsWith("\$GNRMC")) {
              GNRMC.value = element;
              gnrmc.value = NMEA().GNRMCprase(element);
            }
            else if (element.startsWith("\$RUN")) {
              RUN.value = element;
            }
        }

        print(gngst.value);
        print(gnrmc.value);
        print(gngga.value);




        // for (int i = 0; i < decode.length; i++) {
        //   if (decode[i].startsWith("\$GNGGA")) {
        //     GNGGA.value = decode[i];
        //     gngga.value = NMEA().GNGGAprase(decode[i]);
        //   }
        //   else if (decode[i].startsWith("\$GNGST")) {
        //     GNGST.value = decode[i];
        //     gngst.value = NMEA().GNGSTprase(decode[i]);
        //   }
        //   else if (decode[i].startsWith("\$GNRMC")) {
        //     GNRMC.value = decode[i];
        //   }
        //   else if (decode[i].startsWith("\$RUN")) {
        //     RUN.value = decode[i];
        //   }
        // }
      });
    } catch (e) {
      print(e);
      print("Not Connected");
    }
  }
}
