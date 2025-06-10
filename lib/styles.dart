import 'package:flutter/material.dart';

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const beige = Color.fromARGB(184, 167, 121, 62);
  static const transparent = Colors.transparent;
  static const borderBlack = Colors.black12;
}

class AppTextStyles {
  static const nameDetail = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static const priceDetail = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const total = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const nameItem = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const priceItem = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const buy = TextStyle(fontSize: 16, color: AppColors.white);
  static const selectLocation = TextStyle(fontSize: 14, color: AppColors.white);
  static const categoryItem = TextStyle(fontSize: 10);
  static const categoryDetail = TextStyle(fontSize: 16);
  static const priceWithoutDiscount = TextStyle(
    fontSize: 20,
    color: AppColors.grey,
    decoration: TextDecoration.lineThrough,
  );
  static const textWithoutDiscount = TextStyle(color: AppColors.grey, fontSize: 16);
  static const weight = TextStyle(fontWeight: FontWeight.bold);
  static const description = TextStyle(fontSize: 18);
  static const quantityDetail = TextStyle(color: AppColors.white, fontSize: 16);
  static const addToCart = TextStyle(color: AppColors.white, fontSize: 15);
}

class AppButtonStyles {
  static ButtonStyle blackButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  );
}
