import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetDrower extends StatelessWidget {
  const GetDrower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue.withOpacity(.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: NetworkImage(
                      'https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'),
                ),
                Text(
                  "{currentUser!.displayName.toString()}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "{currentUser!.email.toString()}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 5,
            width: size.width,
            color: Colors.blue,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.house_fill),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
            focusColor: Colors.black,
            selectedTileColor: Colors.blue,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.person),
            title: Text(
              'Account',
              style: TextStyle(fontSize: 18),
            ),
            focusColor: Colors.black,
            selectedTileColor: Colors.blue,
          ),
          ListTile(
            selectedTileColor: Colors.blue,
            leading: Icon(CupertinoIcons.arrow_left_circle),
            title: Text(
              'Log out',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
