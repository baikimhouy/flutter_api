import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../constants/app_colors.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  final VoidCallback? onSeeAll;

  const CategorySection({super.key, required this.categories, this.onSeeAll});

  // Static mock — swap for API data via ApiService later
  static const List<CategoryModel> defaultCategories = [
    CategoryModel(
      id: '1',
      name: 'Mobile',
      icon: Icons.smartphone_outlined,
      bgColor: Color(0xFFE8F4FD),
    ),
    CategoryModel(
      id: '2',
      name: 'Watch',
      icon: Icons.watch_outlined,
      bgColor: Color(0xFFE8FDF0),
    ),
    CategoryModel(
      id: '3',
      name: 'Audio',
      icon: Icons.headphones_outlined,
      bgColor: Color(0xFFF3E8FD),
    ),
    CategoryModel(
      id: '4',
      name: 'Gaming',
      icon: Icons.sports_esports_outlined,
      bgColor: Color(0xFFFDE8E8),
    ),
    CategoryModel(
      id: '5',
      name: 'Accessories',
      icon: Icons.shopping_bag_outlined,
      bgColor: Color(0xFFFDF6E8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSectionHeader(),
        const SizedBox(height: 14),
        buildCategoryList(),
      ],
    );
  }

  Widget buildSectionHeader() {
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

  Widget buildCategoryList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map(buildCategoryItem).toList(),
    );
  }

  Widget buildCategoryItem(CategoryModel cat) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(color: cat.bgColor, shape: BoxShape.circle),
          child: Icon(cat.icon, color: AppColors.textDark, size: 26),
        ),
        const SizedBox(height: 6),
        Text(
          cat.name,
          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
        ),
      ],
    );
  }
}
