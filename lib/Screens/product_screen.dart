import 'package:flutter/material.dart';
import 'package:mainproject/Screens/product_detail_screen.dart';
import 'package:mainproject/Services/remote_service.dart';
import 'package:mainproject/model/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
      List<Product> products = await RemoteService().getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return ListTile(
                      leading: Image.network(
                        product.image,
                        height: 50,
                        width: 50,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price.toString()}'),
                      trailing: Text(product.category),
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
    );
  }
}
