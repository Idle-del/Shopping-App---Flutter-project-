import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: Colors.white,
      onTabChange: (value) => onTabChange!(value),
      color: Colors.grey,
      activeColor: Colors.orange,
      tabs: const [
      GButton(
        icon: Icons.home,
        text: "Shop",
        ),
        GButton(
        icon: Icons.shopping_bag_outlined,
        text: "Cart",
        ),
        GButton(
        icon: Icons.person,
        text: "Profile",
        )
    ],);
  }
}