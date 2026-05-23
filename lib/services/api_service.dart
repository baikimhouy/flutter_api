import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchPopularProducts({int limit = 10}) async {
    try {
      final uri = Uri.parse('$_baseUrl/products?limit=$limit');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }
}
