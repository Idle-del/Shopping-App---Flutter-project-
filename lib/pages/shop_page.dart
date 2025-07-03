// ignore_for_file: deprecated_member_use, non_constant_identifier_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_page.dart';
import 'package:mainproject/Screens/electronics_screen.dart';
import 'package:mainproject/Screens/jewellery_screen.dart';
import 'package:mainproject/Screens/men_clothing_screen.dart';
import 'package:mainproject/Screens/product_screen.dart';
import 'package:mainproject/Screens/w_clothing_screen.dart';
import 'package:mainproject/drawer/drawer.dart';

class ShopPage extends StatefulWidget {
  final String userEmail;

  const ShopPage({super.key, required this.userEmail});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String profileImageUrl = '';
  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Men's Clothing",
    "Women's Clothing",
    "Jewellery",
    "Electronics"
  ];

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    try {
      final profileSnapshot = await FirebaseFirestore.instance.collection("ProfileImage").get();
      if (profileSnapshot.docs.isNotEmpty) {
        setState(() {
          profileImageUrl = profileSnapshot.docs[0].data()['image'] ?? '';
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      UserEmail: widget.userEmail,
                      showBackButton: true,
                    ),
                  ),
                );
              },
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : null,
                child: profileImageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
                backgroundColor: Colors.orangeAccent,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search here...",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                      if (category == "Electronics") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ElectronicsScreen(),
                          ),
                        ).then((_) {
                          setState(() {
                            selectedCategory = "All";
                          });
                        });
                      }
                      if (category == "Men's Clothing") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenClothingScreen(),
                          ),
                        ).then((_) {
                          setState(() {
                            selectedCategory = "All";
                          });
                        });
                      }
                      if (category == "Women's Clothing") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WomenClothingScreen(),
                          ),
                        ).then((_) {
                          setState(() {
                            selectedCategory = "All";
                          });
                        });
                      }
                      if (category == "Jewellery") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JewelleryScreen(),
                          ),
                        ).then((_) {
                          setState(() {
                            selectedCategory = "All";
                          });
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == category
                            ? Colors.blue[300]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: selectedCategory == category
                                ? Colors.white
                                : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: selectedCategory == "All"
                  ? const ProductScreen()
                  : const Center(
                      child: Text("No items in this category"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
