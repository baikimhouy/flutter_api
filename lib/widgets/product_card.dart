import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../constants/app_colors.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onAddToCart;

  const ProductCard({super.key, required this.product, this.onAddToCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildImage(), buildInfo()],
      ),
    );
  }

  Widget buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            widget.product.imageUrl,
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 130,
              color: Colors.grey.shade100,
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => setState(
              () => widget.product.isFavourite = !widget.product.isFavourite,
            ),
            child: Icon(
              widget.product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: widget.product.isFavourite ? Colors.red : Colors.grey,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          buildRating(),
          const SizedBox(height: 6),
          buildPriceRow(),
        ],
      ),
    );
  }

  Widget buildRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: AppColors.starColor, size: 14),
        const SizedBox(width: 3),
        Text(
          '${widget.product.rating} (${widget.product.reviewCount})',
          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
        ),
      ],
    );
  }

  Widget buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: AppColors.priceBlue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: widget.onAddToCart,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}
