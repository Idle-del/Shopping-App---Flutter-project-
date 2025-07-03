// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mainproject/pages/bottom_nav_bar.dart';
import 'package:mainproject/pages/cart_page.dart';
import 'package:mainproject/pages/profile_page.dart';
import 'package:mainproject/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  const HomePage({super.key, required this.userEmail });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // ignore: non_constant_identifier_names
  void BottomNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
         //home page
    ShopPage(userEmail: widget.userEmail,),
    //cart page
    const CartPage(),
    //profile page
    ProfilePage(UserEmail: widget.userEmail),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Center(child: const Text("EBazar", style: TextStyle(
                  color: Colors.orangeAccent
                ),)),
                content: const Text("Do you want to LogOut?"),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No", style: TextStyle(
                        color: Colors.lightBlue
                      ),)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Exit", style: TextStyle(
                        color: Colors.lightBlue
                      ),))
                ],
              );
            });
        return value ?? false;
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
                height: 1.0,
              ),
              BottomNav(onTabChange: (index) => BottomNavBar(index)),
            ],
          ),
          body: _pages[_currentIndex],
        ),
      ),
    );
  }
}
