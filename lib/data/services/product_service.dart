import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcs_8/data/models/product.dart';

class ProductService {
  static const String _baseUrl = 'http://localhost:8080/products';

  // Метод для получения списка продуктов
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      // Декодируем JSON и преобразуем его в список объектов Product
      List<dynamic> data = json.decode(response.body);
      return data.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
