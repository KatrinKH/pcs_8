import 'package:flutter/material.dart';

class FavoritesService with ChangeNotifier {
  List<dynamic> _favoriteItems = [];

  List<dynamic> get favoriteItems => _favoriteItems;

  void toggleFavorite(dynamic item) {
    if (_favoriteItems.contains(item)) {
      _favoriteItems.remove(item);
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }

  void removeFromFavorites(dynamic item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }

  bool isFavorite(dynamic item) {
    return _favoriteItems.contains(item);
  }
}
