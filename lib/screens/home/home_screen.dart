import 'package:flutter/material.dart';
import 'package:mini_shop/services/api/api.dart';
import 'package:mini_shop/models/product.dart';
import 'package:mini_shop/screens/cart/cart_screen.dart';
import 'package:mini_shop/screens/map/map_screen.dart';
import 'package:mini_shop/widgets/product/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final API _service = API();

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
      body: FutureBuilder<List<Product>>(
        future: _service.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет товаров'));
          }

          final products = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: products.length,
            itemBuilder: (context, index) => ProductCard(product: products[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
