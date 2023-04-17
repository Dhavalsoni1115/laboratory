class GeoLocation {
  double? lat, long;
  GeoLocation({required this.lat, required this.long});
  GeoLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
