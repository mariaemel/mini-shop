import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/extensions/navigation_extension.dart';
import 'package:mini_shop/features/cart/controller/cart_controller.dart';
import 'package:mini_shop/features/product_details/app/pages/product_detail_page.dart';
import 'package:mini_shop/styles.dart';
import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  bool get hasDiscount => product.discount > 0;

  @override
  Widget build(BuildContext context) {
    final priceText = hasDiscount ? product.discountedPrice.toStringAsFixed(0) : product.price.toStringAsFixed(0);

    return BlocBuilder<CartController, Map<Product, int>>(
      builder: (context, cart) {
        final quantity = cart[product] ?? 0;

        return InkWell(
          onTap: () {
            context.push(ProductDetailPage(product: product));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category, style: AppTextStyles.categoryItem),
                  Text(product.name, style: AppTextStyles.nameItem),
                  const SizedBox(height: 5),
                  Text('$priceText ₽', style: AppTextStyles.priceItem),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: quantity > 0
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => context.read<CartController>().removeFromCart(product),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('$quantity'),
                              IconButton(
                                onPressed: () => context.read<CartController>().addToCart(product),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          )
                        : IconButton(
                            onPressed: () => context.read<CartController>().addToCart(product),
                            icon: const Icon(Icons.shopping_bag_outlined),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
