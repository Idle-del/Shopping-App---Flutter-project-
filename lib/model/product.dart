class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle nested rating object safely
    final ratingData = json['rating'] ?? {};
    final rating = ratingData is Map && ratingData['rate'] != null
        ? (ratingData['rate'] as num).toDouble()
        : 0.0;

    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      rating: rating,
    );
  }
}

