import 'dart:convert';

import 'package:both_platform/auth/signup.dart';
import 'package:both_platform/datbase/db_helper.dart';
import 'package:both_platform/my_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

// ignore: unused_element
String? _userEmail = '';
// ignore: unused_element
String? _userPass = '';
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    getLocationLocate();
    super.initState();
  }

  var currentLatlong;

  getLocationLocate() async {
    Position _position = await _determinePosition();

    setState(() {
      currentLatlong = LatLng(_position.latitude, _position.longitude);
      print(currentLatlong);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: _emailAddress(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: _password(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      final isValid = _formKey.currentState?.validate();
                      FocusScope.of(context).unfocus();
                      if (isValid != null) {
                        if (isValid) {
                          _formKey.currentState?.save();
                          _loginButton(context, currentLatlong);
                          // Use those value to send our auth request for signup..........
                        }
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Need an Account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Register here',
                          style: TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                              // print('Register Button');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Email Widget
Widget _emailAddress() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      textAlign: TextAlign.center,
      controller: emailController,
      key: ValueKey('email'),
      onSaved: (value) {
        _userEmail = value;
      },
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty || !value.contains("@")) {
            return "Pleas enter a valid email address.";
          }
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter your  Email',
        border: InputBorder.none,
      ),
    ),
  );
}

// password widget
Widget _password() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      textAlign: TextAlign.center,
      controller: passwordController,
      key: ValueKey('password'),
      onSaved: (value) {
        _userPass = value;
      },
      validator: (value) {
        if (value != null) {
          if (!value.isNotEmpty || value.length < 4) {
            return "Password must be at list 5 characters long";
          }
        }
      },
      // maxLength: 10,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter your  password',
        border: InputBorder.none,
      ),
    ),
  );
}

/// Login Onpress work
_loginButton(context, currentLatlong) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List userDetails = await DatabaseHelper.instance
      .isUser(emailController.text, passwordController.text);
  emailController.clear();
  passwordController.clear();
  emailController.clear();

  print(userDetails);

  if (userDetails.isEmpty) {
  } else {
    // prefs.setStringList('email', data);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  currentLatlong: currentLatlong,
                  userDetails: userDetails,
                )),
        (route) => false);
  }
}
