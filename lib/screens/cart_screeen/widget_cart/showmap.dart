import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khnomapp/model/location_model.dart';

class showmap extends StatefulWidget {
  final LocationModel value;
  const showmap(
    this.value, {
    Key key,
  }) : super(key: key);

  @override
  State<showmap> createState() => _showmapState();
}

class _showmapState extends State<showmap> {
  Position userLocation;
  GoogleMapController mapController;
  List<Marker> myMarker = [];
  LatLng markerLocation;
  Future startStart;
  CameraUpdate cameraUpdate;
  @override
  void initState() {
    // TODO: implement initState
    startStart = _getLocation();
    super.initState();
  }

  void _onMap(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future _getLocation() async {
    print(widget.value);
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  setlofogus() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        double.parse(widget.value.lat),
        double.parse(widget.value.lng),
      ),
      zoom: 16.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(),
          onTap: widget.value.location_id != null ? setlofogus() : () {},
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 250,
          child: FutureBuilder(
              future: startStart,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: _onMap,
                    myLocationEnabled: true,
                    markers: widget.value.location_id != null
                        ? {
                            Marker(
                              markerId:
                                  MarkerId(widget.value.location_id.toString()),
                              position: LatLng(double.parse(widget.value.lat),
                                  double.parse(widget.value.lng)),
                              infoWindow: InfoWindow(
                                  title: widget.value.location_name.toString()),
                            ),
                          }
                        : Set.from(myMarker),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            userLocation.latitude, userLocation.longitude),
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
        ),
      ],
    );
  }
}
