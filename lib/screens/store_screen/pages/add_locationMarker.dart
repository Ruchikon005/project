import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khnomapp/action/create_location.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/location_model.dart';
import 'package:khnomapp/routes.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class add_locationMarker extends StatefulWidget {
  static var routeName = './add_locationMarker';

  const add_locationMarker({Key key}) : super(key: key);

  @override
  _add_locationMarkerState createState() => _add_locationMarkerState();
}

class _add_locationMarkerState extends State<add_locationMarker> {
  Position userLocation;
  GoogleMapController mapController;
  List<LocationModel> _locationModel = [];
  List<Marker> myMarker = [];
  List<Marker> newMarker = [];
  List<Marker> newList = [];
  static LatLng positionMark;

  static SharedPreferences prefs;
  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  @override
  void initState() {
    // TODO: implement initState
    _getProfile();
    super.initState();
    
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    print('--------------------');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
        ReadLocation();
      });
    }
  }

  Future ReadLocation() async {
    var url = Uri.parse(
        '${ConfigIp.domain}/location/ownerfindlocation/${profile['user_id']}');
    final response = await http.get(url);
    print(response.body);
    var res = convert.jsonDecode(response.body);

    for (var map in res) {
      LocationModel _locationModel = LocationModel.fromJson(map);

      setState(() {
        // multiMarker.add();
        myMarker.add(
          Marker(
              markerId: MarkerId(_locationModel.location_id.toString()),
              position: LatLng(double.parse(_locationModel.lat),
                  double.parse(_locationModel.lng)),
              infoWindow: InfoWindow(title: _locationModel.location_name)),
        );
      });
    }
  }

  void _onMap(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    final stid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().colorCustom,
        title: Text('เพิ่มสถานที่นัดรับ'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: _getLocation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                      mapType: MapType.normal,
                      onMapCreated: _onMap,
                      myLocationEnabled: true,
                      markers: Set.from(myMarker + newMarker),
                      onTap: _handleTap,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              userLocation.latitude, userLocation.longitude),
                          zoom: 16));
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              }),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                if (newMarker.isEmpty) {
                  print('ไม่มีค่า');
                } else {
                  print(positionMark);
                  print(stid);
                  _addLocationDetail(context, stid);
                }
              },
              child: Icon(
                Icons.add,
                size: 50,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(12),
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      newMarker = [];
      newMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString()), position: tappedPoint));
      positionMark = tappedPoint;
      print(positionMark);
    });
  }

  Future<dynamic> _addLocationDetail(BuildContext context, Object stid) async {
    TextEditingController _locationName = TextEditingController();
    TextEditingController _locationDetail = TextEditingController();
    Map modellocation = {
      'location_name': _locationName.text.toString(),
      'location_detail': _locationDetail.text.toString(),
      'lat': positionMark.latitude.toString(),
      'lng': positionMark.longitude.toString(),
      'stid': stid.toString(),
    };
    showDialog(
        context: context,
        builder: (context) => Center(
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    height: 400,
                    width: 400,
                    child: Column(
                      children: [
                        Text(
                          'เพิ่มสถานที่นัดรับ',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _locationName,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'ชื่อสถานที่',
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _locationDetail,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'รายละเอียดสถานที่',
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                        // SizedBox(height: 40),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text('Latitude : Longitude'),
                        //     SizedBox(height: 20),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(positionMark.latitude.toString()),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(positionMark.longitude.toString()),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 40),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                // style: style,
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: Text('CANCEL'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                // style: style,
                                onPressed: () async {
                                  print("ontap");
                                  print(_locationName.text);
                                  await createlocation(modellocation,_locationName.text,_locationDetail.text);
                                  Navigator.pop(context);
                                },
                                child: Text('Okay'),
                              )
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
