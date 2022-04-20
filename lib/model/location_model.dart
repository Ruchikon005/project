class LocationModel {
  final int location_id;
  final String location_name;
  final String location_detail;
  final String lat;
  final String lng;
  final int stid;
  final String createdAt;
  final String updateAt;

  LocationModel({
    this.location_id,
    this.location_name,
    this.location_detail,
    this.lat,
    this.lng,
    this.stid,
    this.createdAt,
    this.updateAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location_id: json['location_id'] as int,
      location_name: json['location_name'] as String,
      location_detail: json['location_detail'] as String,
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      stid: json['stid'] as int,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.location_id;
    data['location_name'] = this.location_name;
    data['location_detail'] = this.location_detail;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['stid'] = this.stid;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
