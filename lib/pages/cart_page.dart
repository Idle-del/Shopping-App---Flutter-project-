// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mainproject/model/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double getTotalAmount() {
    double totalAmount = 0;
    for (var product in Cart.cartItems) {
      totalAmount += product.price;
    }
    return totalAmount;
  }

  Future<void> _checkout() async {
  final cartItems = Cart.cartItems;

  try {
    double totalAmount = getTotalAmount();

    await _firestore.collection('orders').add({
      'products': cartItems.map((product) => {
        'title': product.title,
        'price': product.price,
        'image': product.image,
      }).toList(),
      'totalAmount': totalAmount,
      'createdAt': Timestamp.now(),
    });

    Cart.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed successfully")),
    );

  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error placing order: $error")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final cartItems = Cart.cartItems;
    double totalAmount = getTotalAmount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Cart",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            cartItems.isEmpty
                ? const Center(
                    child: Text("You have nothing in your cart"),
                  )
                : Expanded( // Wrap ListView.builder inside Expanded
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final Product product = cartItems[index];
                        return Card(
                          color: Colors.grey[300],
                          child: ListTile(
                            leading: Image.network(
                              product.image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.title),
                            subtitle: Text("\$${product.price.toString()}"),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  Cart.removeProduct(product);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal:", style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}", 
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: _checkout,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Cart {
  static final List<Product> items = [];

  static void addProduct(Product product) {
    items.add(product);
  }

  static void removeProduct(Product product) {
    items.remove(product);
  }

  static void clearCart() {
    items.clear();
  }

  static List<Product> get cartItems => items;
}
