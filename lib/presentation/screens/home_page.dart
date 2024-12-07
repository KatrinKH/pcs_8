import 'package:flutter/material.dart';
import 'package:pcs_8/data/services/product_service.dart';
import 'package:pcs_8/data/models/product.dart';
import 'package:pcs_8/presentation/widgets/item_note.dart'; 
import 'package:pcs_8/presentation/screens/note_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductService().fetchProducts(); 
  }

  void _deleteProduct(Product product) {
    setState(() {
      // Удаляем продукт из списка
      _products = _products.then((products) {
        products.remove(product);
        return products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видеоигры'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF67BEEA),
      body: FutureBuilder<List<Product>>(
        future: _products, // Загружаем список продуктов
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!; // Получаем список продуктов

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = products[index];

                return GestureDetector(
                  onTap: () {
                    // Навигация на страницу с деталями товара
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotePage(
                          product: product,
                          onDelete: _deleteProduct,
                        ),
                      ),
                    );
                  },
                  child: ItemNote(
                    product: product,
                    onAddToCart: (product, isInCart) {
                      // Логика добавления в корзину
                    },
                    isInCart: false, // Например, пока не добавлено в корзину
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Нет продуктов'));
          }
        },
      ),
    );
  }
}
