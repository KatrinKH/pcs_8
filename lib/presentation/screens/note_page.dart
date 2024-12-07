import 'package:flutter/material.dart';
import 'package:pcs_8/data/models/product.dart'; 

class NotePage extends StatefulWidget {
  final Product product; 
  final Function(Product) onDelete; 

  const NotePage({super.key, required this.product, required this.onDelete});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Подтверждение удаления', style: TextStyle(fontSize: 20)),
          content: Text('Вы уверены, что хотите удалить продукт?', style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                widget.onDelete(widget.product); // Удаляем продукт
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title), // Заголовок с названием продукта
      ),
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                widget.product.title, 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.network(widget.product.imageUrl, width: 340, height: 260), // Отображаем картинку
            ),
            SizedBox(height: 16),
            // Text('Дата релиза: ${widget.product.releaseDate}', style: TextStyle(fontSize: 16)),
            // SizedBox(height: 8),
            // Text('Производитель: ${widget.product.developer}', style: TextStyle(fontSize: 16)),
            // SizedBox(height: 8),
            // Text('Жанр: ${widget.product.genre}', style: TextStyle(fontSize: 16)),
            // SizedBox(height: 8),
            Text(
              'Цена: ${widget.product.price}P', // Цена
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Описание: ${widget.product.description}', // Описание
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red, 
                ),
                child: Text('Удалить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
