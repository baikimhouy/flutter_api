import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CategorySection extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const CategorySection({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildHeader(), const SizedBox(height: 14), _buildList()],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    final categories = [
      {
        'name': 'Mobile',
        'icon': Icons.smartphone_outlined,
        'color': const Color(0xFFE8F4FD),
      },
      {
        'name': 'Watch',
        'icon': Icons.watch_outlined,
        'color': const Color(0xFFE8FDF0),
      },
      {
        'name': 'Audio',
        'icon': Icons.headphones_outlined,
        'color': const Color(0xFFF3E8FD),
      },
      {
        'name': 'Gaming',
        'icon': Icons.sports_esports_outlined,
        'color': const Color(0xFFFDE8E8),
      },
      {
        'name': 'Accessories',
        'icon': Icons.shopping_bag_outlined,
        'color': const Color(0xFFFDF6E8),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: cat['color'] as Color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                cat['icon'] as IconData,
                color: AppColors.textDark,
                size: 26,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              cat['name'] as String,
              style: const TextStyle(fontSize: 12, color: AppColors.textDark),
            ),
          ],
        );
      }).toList(),
    );
  }
}
