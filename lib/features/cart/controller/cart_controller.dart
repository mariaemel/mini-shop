import 'package:flutter_bloc/flutter_bloc.dart';
import '../../products/data/models/product.dart';

class CartController extends Cubit<Map<Product, int>> {
  CartController() : super({});

  void addToCart(Product product) {
    final updatedItems = Map<Product, int>.from(state);
    updatedItems.update(product, (count) => count + 1, ifAbsent: () => 1);
    emit(updatedItems);
  }

  void removeFromCart(Product product) {
    final updatedItems = Map<Product, int>.from(state);
    if (updatedItems.containsKey(product)) {
      final count = updatedItems[product]!;
      if (count > 1) {
        updatedItems[product] = count - 1;
      } else {
        updatedItems.remove(product);
      }
    }
    emit(updatedItems);
  }
}
