// lib/presentation/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:pcs_8/data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('${product.price} ₽'),
      ),
    );
  }
}
