import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import 'widgets/banner.dart';
import 'widgets/category.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/nav.dart';
import '../widgets/product_card.dart';
import 'widgets/special_offer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();

  int _navIndex = 0;
  int _cartCount = 0;
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _api.fetchPopularProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? _buildLoader()
          : _errorMessage != null
          ? _buildError()
          : _buildBody(),
      bottomNavigationBar: MainBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(_errorMessage!, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
              _loadProducts();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GreetingHeader(
              name: 'Yato',
              notificationCount: 3,
              avatarUrl:
                  'https://i.pinimg.com/736x/1a/78/e6/1a78e69cb86bde950b6e72f031ec073b.jpg',
            ),
            const SizedBox(height: 20),
            const HomeSearchBar(),
            const SizedBox(height: 20),
            const BannerCarousel(), 
            const SizedBox(height: 24),
            CategorySection(), 
            const SizedBox(height: 24),
            _buildPopularHeader(),
            const SizedBox(height: 14),
            _buildProductGrid(),
            const SizedBox(height: 24),
            const SpecialOfferBanner(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Popular Products',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See all',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemCount: _products.length,
      itemBuilder: (_, i) => ProductCard(
        product: _products[i],
        onAddToCart: () => setState(() => _cartCount++),
      ),
    );
  }
}
