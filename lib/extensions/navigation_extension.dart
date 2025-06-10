import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T extends Object?>(Widget page) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
}
