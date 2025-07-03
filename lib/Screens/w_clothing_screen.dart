// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mainproject/Screens/product_detail_screen.dart';
import 'package:mainproject/model/product.dart';  // Import Product class
import 'package:mainproject/services/remote_service.dart';  // Import RemoteService

class WomenClothingScreen extends StatefulWidget {
  const WomenClothingScreen({super.key});

  @override
  State<WomenClothingScreen> createState() => _WomenClothingScreenState();
}

class _WomenClothingScreenState extends State<WomenClothingScreen> {
  List<Product> products = [];
  bool isLoading = true;
  final RemoteService remoteService = RemoteService();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Fetch products using RemoteService
  Future<void> _loadProducts() async {
    try {
      List<Product> allProducts = await remoteService.getProducts();
      setState(() {
        // Filter products by "electronics" category
        products = allProducts.where((product) => product.category == "women's clothing").toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error, for example: show a snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load products')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Women's Clothing"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[100]!, Colors.orange[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(product.image),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  Text(
                                    product.rating.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
