import 'package:flutter/material.dart';
import 'package:mini_shop/extensions/navigation_extension.dart';
import 'package:mini_shop/features/cart/app/pages/cart_page.dart';
import 'package:mini_shop/features/map/app/pages/map_page.dart';
import 'package:mini_shop/features/products/app/widgets/category_filter.dart';
import 'package:mini_shop/features/products/app/widgets/search.dart';
import 'package:mini_shop/features/products/data/repos/api.dart';
import 'package:mini_shop/features/products/data/models/product.dart';
import 'package:mini_shop/features/products/app/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final API _service = API();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<String> categories = [];
  Set<String> selectedCategories = {};
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final fetched = await widget._service.fetchCategories();
    setState(() {
      categories = fetched;
      selectedCategories = fetched.toSet();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleCategory(String category) {
    setState(() {
      final allSelected = selectedCategories.length == categories.length;
      if (category == 'Все категории') {
        selectedCategories = allSelected ? {} : categories.toSet();
      } else {
        if (allSelected) {
          selectedCategories = {category};
        } else {
          if (selectedCategories.contains(category)) {
            selectedCategories.remove(category);
          } else {
            selectedCategories.add(category);
          }
        }
      }
    });
  }

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
      body: Column(
        children: [
          Search(controller: _searchController, onChanged: (value) => setState(() => searchQuery = value)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CategoryFilter(
                    categories: categories,
                    selectedCategories: selectedCategories,
                    onSelected: _toggleCategory,
                  ),
                  const Text('Фильтр'),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: widget._service.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }

                var products = snapshot.data!;

                if (searchQuery.isNotEmpty) {
                  products = products.where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
                }

                products = products.where((p) => selectedCategories.contains(p.category)).toList();

                if (products.isEmpty) {
                  return const Center(child: Text('Нет товаров'));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductCard(product: products[index]),
                );
              },
            ),
          ),
        ],
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
