import 'package:dio/dio.dart';
import '../../models/product.dart';

class API {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://api.fores.space:8080'));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('/products/list');
      final data = response.data as List;

      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Product> fetchProductById(String id) async {
    try {
      final response = await _dio.get('/products/current/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
