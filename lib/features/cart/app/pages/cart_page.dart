import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop/features/products/data/models/product.dart';
import 'package:mini_shop/styles.dart';
import '../../controller/cart_controller.dart';
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: BlocBuilder<CartController, Map<Product, int>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return const Center(child: Text('Корзина пуста'));
          }
          final cartProducts = cart.entries.toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              final entry = cartProducts[index];
              return CartItem(product: entry.key, quantity: entry.value);
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartController, Map<Product, int>>(
        builder: (context, cart) {
          if (cart.isEmpty) return const SizedBox.shrink();

          final total = cart.entries.fold<double>(0, (sum, entry) => sum + (entry.key.discountedPrice * entry.value));

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderBlack)),
              color: AppColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Итого:', style: AppTextStyles.total),
                    Text('${total.toStringAsFixed(0)} ₽', style: AppTextStyles.total),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: AppButtonStyles.blackButton,
                    child: const Text('Купить', style: AppTextStyles.buy),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
