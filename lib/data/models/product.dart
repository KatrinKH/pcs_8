class Product {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      imageUrl: json['ImageURL'],
      name: json['Name'],
      description: json['Description'],
      price: (json['Price'] as num).toDouble(),
    );
  }
}
