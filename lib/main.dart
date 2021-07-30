import 'package:both_platform/auth/login.dart';
// ignore: unused_import
import 'package:both_platform/auth/signup.dart';
import 'package:both_platform/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:io' show Platform;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white.withOpacity(.6),
        appBarTheme: AppBarTheme(color: Colors.black),
        buttonColor: Colors.blue,
        cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
          primaryColor: Colors.white,
        ),
        buttonTheme: ButtonThemeData(),
        primarySwatch: Colors.blue,
      ),
      home: SecondPage(),
    );
  }
}
