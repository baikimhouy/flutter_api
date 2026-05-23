import 'package:flutter/material.dart';
import 'package:midterm/widgets/banner_carousel.dart';
import 'package:midterm/widgets/category_section.dart';
import 'package:midterm/widgets/greeting_header.dart';
import 'package:midterm/widgets/home_search_bar.dart';
import 'package:midterm/widgets/product_card.dart';
import 'package:midterm/widgets/special_offer_banner.dart';
import '../constants/app_colors.dart';
import '../models/product_model.dart';
import '../models/banner_model.dart';
import '../services/api_service.dart';
import 'widgets/main_bottom_nav.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();

  int _navIndex = 0;
  int _cartCount = 0;

  List<BannerModel> _banners = [];
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _errorMessage;


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  
Future<void> _loadData() async {
    try {
      final banners = await _api.fetchBanners();
      final products = await _api.fetchPopularProducts(limit: 10);
      setState(() {
        _banners = banners;
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
          ? buildLoader()
          : _errorMessage != null
          ? buildError()
          : buildBody(),
      bottomNavigationBar: MainBottomNav(
        currentIndex: _navIndex,
        cartCount: _cartCount,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }

  Widget buildError() {
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
              setState(() => _isLoading = true);
              _loadData();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget buildLoader() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget buildBody() {
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
            BannerCarousel(banners: _banners),
            const SizedBox(height: 24),
            CategorySection(
              categories: CategorySection.defaultCategories,
              onSeeAll: () {},
            ),
            const SizedBox(height: 24),
            buildPopularHeader(),
            const SizedBox(height: 14),
            buildProductList(),
            const SizedBox(height: 24),
            const SpecialOfferBanner(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildPopularHeader() {
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

  Widget buildProductList() {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) => ProductCard(
          product: _products[i],
          onAddToCart: () => setState(() => _cartCount++),
        ),
      ),
    );
  }
}

