class GNGGAmodel{
  String? utc;
  String? lat;
  String? latDir;
  String? lon;
  String? lonDir;
  String? quality;
  String? sats;//numberSatellites;
  String? hdop;
  String? altitude;
  String? altitudeUnit;
  String? geoid ;
  String? geoiduUints ;
  String? age;
  String? stnId;

  @override
  String toString() {
    return 'GNGGAmodel{utc: $utc, lat: $lat, latDir: $latDir, lon: $lon, lonDir: $lonDir, quality: $quality, sats: $sats, hdop: $hdop, altitude: $altitude, altitudeUnit: $altitudeUnit, geoid: $geoid, geoiduUints: $geoiduUints, age: $age, stnId: $stnId}';
  }
}