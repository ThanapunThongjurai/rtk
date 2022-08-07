class GNGGAmodel{
  String? utc;
  String? lat;
  String? latDir;
  String? lon;
  String? lonDir;
  String? quality;
  String? sats;//numberSatellites;
  String? hdop;
  String? aUnits;
  String? undulation;
  String? uUints;
  String? refBaseStation;
  String? age;
  String? stnId;

  @override
  String toString() {
    return 'GNGGAmodel{utc: $utc, lat: $lat, latDir: $latDir, lon: $lon, lonDir: $lonDir, quality: $quality, sats: $sats, hdop: $hdop, aUnits: $aUnits, undulation: $undulation, uUints: $uUints, refBaseStation: $refBaseStation, age: $age, stnId: $stnId}';
  }
}