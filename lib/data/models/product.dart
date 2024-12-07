class Product {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      imageUrl: json['ImageURL'],
      title: json['Name'],
      description: json['Description'],
      price: (json['Price'] as num).toDouble(),
    );
  }
}
