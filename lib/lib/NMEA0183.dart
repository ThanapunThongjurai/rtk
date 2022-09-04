import 'dart:convert';

import 'package:rtk/datamodel/GNGSTmodel.dart';
import 'package:rtk/datamodel/GNRMCmodel.dart';

import '../datamodel/GNGGAmodel.dart';

class NMEA {
  List<String> SplitData(String data) {
    LineSplitter ls = new LineSplitter();
    List<String> decode = ls.convert(data);

    for (int i = 0; i < decode.length; i++) {
      //TODO CHECKSUM
      if (decode[i] == null) {
        decode.removeAt(i);
      }
    }
    return decode;
  }

  double ds_to_sd(String data) {
    List<String> decode = data.split(("."));
    int dd = int.parse(decode[0].substring(0, decode[0].length - 2));
    double mm = double.parse(
        decode[0].substring(decode[0].length - 2, decode[0].length) +
            "." +
            decode[1]);
    print(dd);
    print(mm);
    return dd + (mm / 60);
  }

  bool CheckSum(String dataMessage) {
    int checksumResult = 0;
    List<int> messageBytes = utf8.encode(dataMessage.toUpperCase());
    List<int> messageBytesCut =
        messageBytes.sublist(1, messageBytes.length - 3);
    int sum = int.parse("0x" +
        dataMessage.substring(messageBytes.length - 2, messageBytes.length));
    for (int i = 0; i < messageBytesCut.length; i++) {
      checksumResult = checksumResult ^ messageBytesCut[i];
    }
    // print("data : ${dataMessage}");
    // print(utf8.decode(messageBytesCut));
    // print("sum : ${sum}");
    // print("checksumResult : ${checksumResult}");
    if ((checksumResult == sum)) {
      // print("check : true");
      // print("");
      return true;
    } else {
      // print("check : false");
      // print("");
      return false;
    }
  }

  GNGGAmodel GNGGAprase(String data) {
    GNGGAmodel res = new GNGGAmodel();
    List<String> decode = data.split((","));
    res.utc = decode[1];
    res.lat = decode[2];
    res.latDir = decode[3];
    res.lon = decode[4];
    res.lonDir = decode[5];
    res.quality = decode[6];
    res.sats = decode[7];
    res.hdop = decode[8];
    res.aUnits = decode[9];
    res.undulation = decode[10];
    res.undulation = decode[11];
    res.refBaseStation = decode[12];
    res.age = decode[13];
    res.stnId = decode[14].substring(0, decode[14].length - 3);

    //res.refBaseStation = decode[12].substring(0,decode[12].length-3);

    return res;
  }

  GNGSTmodel GNGSTprase(String data) {
    GNGSTmodel res = new GNGSTmodel();

    List<String> decode = data.split((","));
    res.utc = decode[1];
    if (decode[2] != "") res.rms = decode[2];
    if (decode[3] != "") res.smjr = decode[3];
    if (decode[4] != "") res.smnr = decode[4];
    if (decode[5] != "") res.orient = decode[5];
    if (decode[6] != "") res.lat = decode[6];
    if (decode[7] != "") res.lon = decode[7];
    if (decode[8] != "") res.alt = decode[8].substring(0, decode[8].length - 3);

    return res;
  }

  GNRMCmodel GNRMCprase(String data) {
    GNRMCmodel res = new GNRMCmodel();
    List<String> decode = data.split((","));
    print(decode);
    res.utc = decode[1];
    res.posStatus = decode[2];
    res.lat = decode[3];
    res.latDir = decode[4];
    res.lon = decode[5];
    res.lonDir = decode[6];
    res.speedKn = decode[7];
    res.trackTrue = decode[8];
    res.date = decode[9];
    res.magVar = decode[10];
    res.varDir = decode[11];
    res.modeInd = decode[12];
    //res.modeInd = decode[12].substring(0,decode[12].length-3);
    return res;
  }
}
