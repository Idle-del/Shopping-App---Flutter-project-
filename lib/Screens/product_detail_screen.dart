import 'package:flutter/material.dart';
import 'package:mainproject/model/product.dart';
import 'package:mainproject/pages/cart_page.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 200);
              },
            ),
            const SizedBox(height: 16),
            Text(product.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${product.price}',
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 8),
            Text('Category: ${product.category}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Rating: ', style: TextStyle(fontSize: 16)),
                Text('${product.rating}',
                    style: const TextStyle(fontSize: 16, color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 16),
            Text(product.description),

            const SizedBox(height: 30,),

            ElevatedButton(onPressed: (){
               Cart.addProduct(product);
               showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("SUCESS", style: TextStyle(
                            color: Colors.green
                          ),),
                          content: const Text("product added to Cart!"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK", style: TextStyle(
                                  color: Colors.lightBlue
                                ),))
                          ],
                        );
                      });
            },
             child: const Text("Add To Cart"))
          ],
        ),
      ),
    );
  }
}