import 'package:flutter/material.dart';
import 'package:mini_shop/screens/product_card.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = [
    Product(
      name: 'название',
      category: 'категория',
      price: 100.00,
      discount: 20.00,
      description: 'описание',
      weight: '200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мини-магазин'), centerTitle: true),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}
