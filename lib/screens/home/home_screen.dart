import 'package:flutter/material.dart';
import 'package:mini_shop/screens/cart/cart_screen.dart';
import 'package:mini_shop/widgets/product/product_card.dart';
import '../../models/product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = [
    Product(
      name: 'название',
      category: 'категория',
      price: 100.00,
      discount: 20.00,
      description: 'описание описание описание описание описание описание описание',
      weight: '200',
    ),
    Product(
      name: 'название2',
      category: 'категория',
      price: 100.00,
      discount: 30.00,
      description: 'описание описание описание описание описание описание описание',
      weight: '200',
    ),
    Product(
      name: 'название3',
      category: 'категория',
      price: 100.00,
      discount: 40.00,
      description: 'описание описание описание описание описание описание описание',
      weight: '200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мини-магазин'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }
}
