import 'package:flutter/material.dart';
import 'package:mini_shop/extensions/navigation_extension.dart';
import 'package:mini_shop/features/cart/app/pages/cart_page.dart';
import 'package:mini_shop/features/map/app/pages/map_page.dart';
import 'package:mini_shop/features/products/data/repos/api.dart';
import 'package:mini_shop/features/products/data/models/product.dart';
import 'package:mini_shop/features/products/app/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final API _service = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мини-магазин'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(CartPage());
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
          context.push(const MapPage());
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
