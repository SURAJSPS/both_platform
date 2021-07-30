import 'dart:async';

import 'package:both_platform/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentLatlong;

  @override
  void initState() {
    getLocationLocate();
    super.initState();
  }

  getLocationLocate() async {
    Position _position = await _determinePosition();

    setState(() {
      currentLatlong = new LatLng(_position.latitude, _position.longitude);
    });
  }
// Location permissions 
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  
// Use for the marker 
  Set<Marker> _marker = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('Id_0'),
          position: currentLatlong,
          infoWindow: InfoWindow(title: "Your location")));
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _marker,
            initialCameraPosition: CameraPosition(
              target: currentLatlong,
              zoom: 11.0,
            ),
          ),
          Container(
            color: Colors.amber[50],
            alignment: Alignment.bottomRight,
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                Text('dahgjhgfjhkgjhjhkta'),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: MediaQuery.of(context).size.width / 4,
            child: CupertinoButton(
              color: Colors.blue,
              child: Text(
                'NEXT PAGE',
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
