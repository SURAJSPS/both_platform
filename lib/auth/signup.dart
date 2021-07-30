import 'dart:io';

import 'package:both_platform/datbase/data_model.dart';
import 'package:both_platform/datbase/db_helper.dart';

import 'package:both_platform/my_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  var currentLatlong;
  Register({Key? key, this.currentLatlong}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();

final passwordController = TextEditingController();
final confPasswordController = TextEditingController();
// ignore: unused_element
String? _userEmail = '';
// ignore: unused_element
String? _userNam = '';
// ignore: unused_element
String? _userPhone = '';

// ignore: unused_element
String? _userPassword = '';
// ignore: unused_element
String? _userConformPassword = '';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _RegisterState extends State<Register> {
  PickedFile? _image;

  _imgFromCamera() async {
    PickedFile? image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile? image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Creat an Account',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                getImage(context, _image, _showPicker),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: _userName(),
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
                  child: _phoneNumber(),
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
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: _confPassword(),
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
                        _creatAccount(context, widget.currentLatlong);

                        // Use those value to send our auth request for signup..........
                      }
                    }
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        print('gallary');
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      print('Camera');
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
      validator: (value) {
        if (value != null) {
          if (!value.isNotEmpty || !value.contains("@")) {
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

Widget _userName() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      textAlign: TextAlign.center,
      controller: nameController,
      key: ValueKey('userName'),
      onSaved: (value) {
        _userNam = value;
      },
      validator: (value) {
        if (value != null) {
          if (!value.isNotEmpty) {
            return "Pleas enter a full Name.";
          }
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter your  Full Name',
        border: InputBorder.none,
      ),
    ),
  );
}

Widget _phoneNumber() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      textAlign: TextAlign.center,
      // maxLength: 10,
      controller: phoneController,
      key: ValueKey('userPhone'),
      onSaved: (value) {
        _userPhone = value;
      },
      validator: (value) {
        if (value != null) {
          if (!value.isNotEmpty) {
            return "Pleas enter valid phone Number.";
          }
          if (value.length > 10) {
            return "Pleas enter 10 digit phone Number.";
          }
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter your  Phone Number',
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
        _userPassword = value;
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

// conform password widget
Widget _confPassword() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextFormField(
      textAlign: TextAlign.center,
      controller: confPasswordController,
      key: ValueKey('conformPassword'),
      validator: (value) {
        if (value != null) {
          if (value.isEmpty || value.length < 4) {
            return "Your password should not match";
          }
        }
        return null;
      },
      onSaved: (value) {
        _userConformPassword = value;
      },
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration.collapsed(
        hintText: 'Enter Conform Password',
        border: InputBorder.none,
      ),
    ),
  );
}

/// creat account button
_creatAccount(context, currentLatlong) async {
  // ignore: await_only_futures
  await DatabaseHelper.instance;

  UserDataModel _model = UserDataModel(
    email: emailController.text,
    password: passwordController.text,
    image: confPasswordController.text,
    name: nameController.text,
    phone: phoneController.text,
  );

  await DatabaseHelper.instance.insertUser(_model).then(
        (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      currentLatlong: currentLatlong,
                    )),
            (route) => false),
      );
}

Widget getImage(context, _image, _showPicker) {
  return Column(
    children: <Widget>[
      Center(
        child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xffFDCF09),
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
          ),
        ),
      )
    ],
  );
}
