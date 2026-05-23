import 'package:flutter/material.dart';
import '../../models/banner_model.dart';
import '../../constants/app_colors.dart';

class BannerCarousel extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (_, i) => buildBannerCard(widget.banners[i]),
          ),
        ),
        const SizedBox(height: 10),
        buildDots(),
      ],
    );
  }

  Widget buildBannerCard(BannerModel banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          buildCircleDecoration(), // big soft circle in background
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Expanded(child: buildBannerText(banner)),
                buildBannerImage(banner),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // soft decorative circle behind the headphone
  Widget buildCircleDecoration() {
    return Positioned(
      right: -30,
      top: -30,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.35),
        ),
      ),
    );
  }

  Widget buildBannerText(BannerModel banner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          banner.tag,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          banner.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          banner.subtitle,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
        ),
        const SizedBox(height: 14),
        buildShopButton(banner.buttonText),
      ],
    );
  }

  Widget buildShopButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget buildBannerImage(BannerModel banner) {
    if (banner.assetImage != null) {
      // ── local asset ──────────────────────────────────────────
      return Image.asset(
        banner.assetImage!,
        width: 150,
        height: 150,
        fit: BoxFit.contain,
      );
    } else if (banner.imageUrl != null) {
      // ── network fallback ─────────────────────────────────────
      return Image.network(
        banner.imageUrl!,
        width: 130,
        height: 130,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.image, size: 80, color: Colors.grey),
      );
    }
    return const SizedBox(width: 130);
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.banners.length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _currentIndex == i ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: _currentIndex == i
                ? AppColors.primary
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
