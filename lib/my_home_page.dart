import 'package:both_platform/datbase/data_model.dart';
import 'package:both_platform/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  var currentLatlong;
  // UserDataModel? userDataModel;
  MyHomePage({
    Key? key,
    @required this.currentLatlong,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              color: Colors.amber[50],
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height / 8.99,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 20,
                  ),
                  Text(
                    "{widget.userDataModel!.name}",
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
