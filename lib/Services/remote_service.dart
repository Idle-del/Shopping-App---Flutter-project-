import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mainproject/model/product.dart';

class RemoteService {

  Future<List<Product>> getProducts () async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
