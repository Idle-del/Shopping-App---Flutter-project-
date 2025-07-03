// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mainproject/pages/shop_page.dart';

class ProfilePage extends StatefulWidget {
  final String UserEmail;
  final bool showBackButton;
  const ProfilePage({super.key, required this.UserEmail, this.showBackButton = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference _userInfo = FirebaseFirestore.instance.collection("users");
  final CollectionReference _profileImage = FirebaseFirestore.instance.collection("ProfileImage");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackButton,
        leading: widget.showBackButton ? IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ShopPage(userEmail: 'widget.userEmail',),
              )
            );
          },
          icon: Icon(Icons.arrow_back)) 
          : null,
        title: const Center(
          child: Text(
            "My Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        // automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userInfo.where('email', isEqualTo: widget.UserEmail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: $snapshot.error"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          }

          final dataDocs = snapshot.data!.docs;
          final data = dataDocs[0].data() as Map<String, dynamic>;

          return StreamBuilder<QuerySnapshot>(
            stream: _profileImage.snapshots(),
            builder: (context, imageSnapshot) {
              if (imageSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (imageSnapshot.hasError) {
                return Center(child: Text("Error: ${imageSnapshot.error}"));
              }
              if (!imageSnapshot.hasData || imageSnapshot.data!.docs.isEmpty) {
                return Center(child: Text("No profile image available"));
              }

              final imageDoc = imageSnapshot.data!.docs[0].data() as Map<String, dynamic>;
              final imageUrl = imageDoc['image'] ?? '';
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    imageUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(imageUrl),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.orangeAccent,
                            child: Icon(Icons.person, size: 60, color: Colors.white),
                          ),
                    const SizedBox(height: 20),

                    // EMAIL Section
                    Text(
                      "EMAIL",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['email'] ?? 'No email',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    const Divider(color: Colors.orangeAccent, thickness: 1.5),
                    const SizedBox(height: 15),

                    // USER NAME Section
                    Text(
                      "USER NAME",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['name'] ?? 'No name',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    const Divider(color: Colors.orangeAccent, thickness: 1.5),
                    const SizedBox(height: 15),

                    // ADDRESS Section
                    Text(
                      "ADDRESS",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['address'] ?? 'No address',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    const Divider(color: Colors.orangeAccent, thickness: 1.5),
                    const SizedBox(height: 15),

                    // CONTACT Section
                    Text(
                      "CONTACT",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['phone'] ?? 'No phone number',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    const Divider(color: Colors.orangeAccent, thickness: 1.5),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
