import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  List<dynamic> _cartItems = [];

  List<dynamic> get cartItems => _cartItems;

  void addToCart(dynamic item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(dynamic item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  bool isCartEmpty() {
    return _cartItems.isEmpty;
  }
}
