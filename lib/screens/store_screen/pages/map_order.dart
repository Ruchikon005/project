import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khnomapp/action/get_location.dart';
import 'package:khnomapp/model/location_model.dart';

class mapOrder extends StatefulWidget {
  static String routeName = '/map_order';

  @override
  State<mapOrder> createState() => _mapOrderState();
}

class _mapOrderState extends State<mapOrder> {
  Position userLocation;
  GoogleMapController mapController;
  List<Marker> myMarker = [];
  LatLng markerLocation;
  CameraUpdate cameraUpdate;
  LocationModel locationModel = LocationModel();

  void _onMap(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  Future _getLocationname(argloname) async {
    var data = await getlocationname(argloname);
    print(data);
    print('Testtttttttttttttttttttttttttttttttttt');
    locationModel = LocationModel.fromJson(data);
    await _getLocation();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final argloname = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$argloname',
          style: TextStyle(
              color: Color.fromARGB(255, 61, 61, 61),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: _getLocationname(argloname),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMap,
                myLocationEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId(locationModel.location_id.toString()),
                    position: LatLng(double.parse(locationModel.lat),
                        double.parse(locationModel.lng)),
                    infoWindow: InfoWindow(
                        title: locationModel.location_name.toString()),
                  ),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(locationModel.lat),
                        double.parse(locationModel.lng)),
                    zoom: 16),
              );
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
    );
  }
}
