import 'package:flutter/material.dart';
import 'package:mainproject/drawer/list_tile.dart';
// import 'package:mainproject/Screens/profile_page.dart';

class MyDrawer extends StatelessWidget {
  // final String userEmail;
  const MyDrawer({super.key, });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          //icon
          const DrawerHeader(
              child: Image(image: AssetImage("lib/images/ebazar.jpg"))),
          //home
          MyListTile(
            icon: Icons.home,
            text: "H O M E",
            onTap: () => Navigator.pop(context),
          ),
          //profile
          // MyListTile(
          //     icon: Icons.person,
          //     text: "P R O F I L E",
          //     onTap: () => Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ProfilePage(UserEmail: userEmail ))))
        ],
      ),
    );
  }
}
