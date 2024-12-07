// lib/presentation/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:pcs_8/data/models/product.dart';
import 'package:pcs_8/data/services/product_service.dart';
import 'package:pcs_8/presentation/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ProductService().fetchProducts();  // Загружаем продукты при инициализации экрана
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());  // Индикатор загрузки
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));  // Показ ошибки
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return ProductCard(product: product);  // Использование карточки продукта
              },
            );
          } else {
            return Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}
