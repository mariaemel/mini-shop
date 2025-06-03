import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  bool get hasDiscount => product.discount > 0;

  @override
  Widget build(BuildContext context) {
    final priceText = hasDiscount ? product.discountedPrice.toStringAsFixed(0) : product.price.toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.category, style: const TextStyle(fontSize: 16)),
            Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$priceText ₽', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      hasDiscount ? 'со скидкой ${product.discount.toStringAsFixed(0)}%' : 'без скидки',
                      style: TextStyle(
                        color: hasDiscount ? const Color.fromARGB(184, 167, 121, 62) : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                if (hasDiscount)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} ₽',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Text('без скидки', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.transparent,
                  ),
                  child: Text(product.weight, style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(width: 8),
                const Text('объём/вес'),
              ],
            ),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
              label: const Text("Добавить в корзину", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
