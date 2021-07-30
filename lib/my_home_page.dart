import 'dart:io';

import 'package:both_platform/datbase/data_model.dart';
import 'package:both_platform/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  var currentLatlong;
  List? userDetails;
  MyHomePage({Key? key, @required this.currentLatlong, this.userDetails})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _file;

// Use for the marker
  Set<Marker> _marker = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('Id_0'),
          position: widget.currentLatlong,
          infoWindow: InfoWindow(title: "Your location")));
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              onMapCreated: _onMapCreated,
              markers: _marker,
              initialCameraPosition: CameraPosition(
                target: widget.currentLatlong,
                zoom: 11.0,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 8.99,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (_file != null)
                      ? CircleAvatar(
                          backgroundImage: FileImage(
                              _file = (widget.userDetails![0]['image']).path),
                          radius: 20,
                        )
                      : CircleAvatar(),
                  Text(
                    "${widget.userDetails![0]['name']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
      ),
    );
  }
}
