import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/features/cart/controller/cart_controller.dart';
import 'package:mini_shop/styles.dart';
import '../../../products/data/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

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
            Text(product.category, style: AppTextStyles.categoryDetail),
            Text(product.name, style: AppTextStyles.nameDetail),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$priceText ₽', style: AppTextStyles.priceDetail),
                    Text(
                      hasDiscount ? 'со скидкой ${product.discount.toStringAsFixed(0)}%' : 'без скидки',
                      style: TextStyle(color: hasDiscount ? AppColors.beige : AppColors.grey, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                if (hasDiscount)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${product.price.toStringAsFixed(0)} ₽', style: AppTextStyles.priceWithoutDiscount),
                      const Text('без скидки', style: AppTextStyles.textWithoutDiscount),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (product.weight != null) ...[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black, width: 1),
                      color: AppColors.transparent,
                    ),
                    child: Text(product.weight!, style: AppTextStyles.weight),
                  ),
                  const SizedBox(width: 8),
                  const Text('объём/вес'),
                ],
              ),
            ],
            const SizedBox(height: 8),
            if (product.description != null) ...[Text(product.description!, style: AppTextStyles.description)],
            const SizedBox(height: 20),
            BlocBuilder<CartController, Map<Product, int>>(
              builder: (context, cart) {
                final quantity = cart[product] ?? 0;
                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: quantity > 0
                      ? Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.read<CartController>().removeFromCart(product),
                                child: Container(
                                  color: AppColors.black,
                                  child: const Center(child: Icon(Icons.remove, color: AppColors.white)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: AppColors.black,
                                child: Center(child: Text('$quantity', style: AppTextStyles.quantityDetail)),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.read<CartController>().addToCart(product),
                                child: Container(
                                  color: AppColors.black,
                                  child: const Center(child: Icon(Icons.add, color: AppColors.white)),
                                ),
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            context.read<CartController>().addToCart(product);
                          },
                          icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
                          label: const Text("Добавить в корзину", style: AppTextStyles.addToCart),
                          style: AppButtonStyles.blackButton,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
