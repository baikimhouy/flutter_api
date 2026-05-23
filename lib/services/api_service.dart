import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/banner_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1'; // ✅ fixed

  // ── Banners — mock ────────────────────────────────────────────────────────
  Future<List<BannerModel>> fetchBanners() async {
    return _mockBanners;
  }

  // ── Products — real API ───────────────────────────────────────────────────
  Future<List<ProductModel>> fetchPopularProducts({int limit = 10}) async {
    try {
      final uri = Uri.parse('$_baseUrl/products?limit=$limit'); // ✅ correct URL
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('fetchPopularProducts error: $e');
      return _mockProducts; // fallback on error
    }
  }

  // ── Mock data ─────────────────────────────────────────────────────────────
  static final List<BannerModel> _mockBanners = [
    BannerModel(
      tag: 'Summer Sale',
      title: 'Up to 50% OFF',
      subtitle: 'On selected items',
      buttonText: 'Shop Now',
      assetImage: 'assets/images/head.png',
    ),
    BannerModel(
      tag: 'New Arrivals',
      title: 'Fresh Styles',
      subtitle: 'Check latest collections',
      buttonText: 'Explore',
      assetImage: 'assets/images/head.png',
    ),
  ];

  static final List<ProductModel> _mockProducts = [
    ProductModel(
      id: '1',
      name: 'Nike Air Max 270',
      price: 120.00,
      rating: 4.8,
      reviewCount: 230,
      imageUrl:
          'https://i.pinimg.com/1200x/82/3a/24/823a246245bebd2429dd614414bda6f9.jpg',
    ),
    ProductModel(
      id: '2',
      name: 'Fujifilm X-T30 II',
      price: 249.00,
      rating: 4.6,
      reviewCount: 185,
      imageUrl:
          'https://i.pinimg.com/1200x/3f/f2/99/3ff2995449ce65c7ccd4f5746966e262.jpg',
    ),
    ProductModel(
      id: '3',
      name: 'Tiffany & Co Metro Watch',
      price: 399.00,
      rating: 4.7,
      reviewCount: 310,
      imageUrl:
          'https://i.pinimg.com/736x/c7/3c/9e/c73c9ea2e83886df5ebe952081d1a85c.jpg',
    ),
  ];
}
