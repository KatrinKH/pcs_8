// lib/presentation/widgets/item_note.dart
import 'package:flutter/material.dart';
import 'package:pcs_8/data/models/product.dart'; 

class ItemNote extends StatefulWidget {
  final Product product;
  final Function(Product, bool) onAddToCart;
  final bool isInCart;

  const ItemNote({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.isInCart,
  });

  @override
  _ItemNoteState createState() => _ItemNoteState();
}

class _ItemNoteState extends State<ItemNote> {
  late bool _isInCart;

  @override
  void initState() {
    super.initState();
    _isInCart = widget.isInCart;
  }

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart;
    });
    widget.onAddToCart(widget.product, _isInCart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                widget.product.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.network(widget.product.imageUrl, fit: BoxFit.cover), // Загрузка изображения из сети
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '- Цена: ${widget.product.price} рублей',
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: _isInCart ? Colors.green : Colors.black,
                ),
                onPressed: _toggleCart,
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  // Логика добавления в избранное
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
