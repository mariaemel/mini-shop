class Product {
  final String name;
  final String category;
  final double price;
  final double discount;
  final String description;
  final String weight;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.description,
    required this.weight,
  });

  double get discountedPrice => price * (1 - discount / 100);
}
