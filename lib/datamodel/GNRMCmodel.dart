class GNRMCmodel {
  String? utc;
  String? posStatus;
  String? lat;
  String? latDir;
  String? lon;
  String? lonDir;
  String? speedKn;
  String? trackTrue;
  String? date;
  String? magVar;
  String? varDir;
  String? modeInd;
  String? Navigationreceiverwarning;

  @override
  String toString() {
    return 'GNRMCmodel{utc: $utc, posStatus: $posStatus, lat: $lat, latDir: $latDir, lon: $lon, lonDir: $lonDir, speedKn: $speedKn, trackTrue: $trackTrue, date: $date, magVar: $magVar, varDir: $varDir, modeInd: $modeInd, Navigationreceiverwarning: $Navigationreceiverwarning}';
  }
}
