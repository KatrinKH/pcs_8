import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/services/favorites_service.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);

    if (favoritesService.favoriteItems.isEmpty) {
      return const Center(child: Text('No favorite items'));
    }

    return ListView.builder(
      itemCount: favoritesService.favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoritesService.favoriteItems[index];
        return ListTile(
          title: Text(item['title']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              favoritesService.removeFromFavorites(item);
            },
          ),
        );
      },
    );
  }
}
