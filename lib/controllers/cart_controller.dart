import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';

class CartState {
  final List<Product> items;

  CartState({this.items = const []});
}

class CartController extends Cubit<CartState> {
  CartController() : super(CartState());

  void addToCart(Product product) {
    final updated = List<Product>.from(state.items)..add(product);
    emit(CartState(items: updated));
  }

  void removeFromCart(Product product) {
    final updated = List<Product>.from(state.items)..remove(product);
    emit(CartState(items: updated));
  }
}
