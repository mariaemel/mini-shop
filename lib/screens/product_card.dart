import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  bool get hasDiscount => product.discount > 0;

  @override
  Widget build(BuildContext context) {
    final priceText = hasDiscount ? product.discountedPrice.toStringAsFixed(0) : product.price.toStringAsFixed(0);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.category, style: const TextStyle(fontSize: 12)),
            Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$priceText ₽', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      hasDiscount ? 'со скидкой ${product.discount.toStringAsFixed(0)}%' : 'без скидки',
                      style: TextStyle(
                        color: hasDiscount ? const Color.fromARGB(184, 167, 121, 62) : Colors.grey,
                        fontSize: 12,
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
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Text('без скидки', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
