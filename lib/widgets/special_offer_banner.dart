import 'package:flutter/material.dart';

class SpecialOfferBanner extends StatelessWidget {
  const SpecialOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 239, 253),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          buildIcon(),
          const SizedBox(width: 16),
          buildText(),
          const Spacer(),
          buildTruck(),
        ],
      ),
    );
  }

  Widget buildIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 116, 155, 240),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/offer_icon.png',
          fit: BoxFit.contain,
          // fallback: if image missing during dev, shows icon instead
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.local_offer, color: Colors.white, size: 26),
        ),
      ),
    );
  }

  Widget buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Special Offer',
          style: TextStyle(
            color: Color.fromARGB(255, 116, 155, 240),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Text(
          'Free Shipping',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          'On orders over \$50',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget buildTruck() {
    return Image.asset(
      'assets/images/truk.png',
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      // fallback: if image missing during dev, shows icon instead
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.local_shipping, size: 48, color: Color(0xFF2ECC71)),
    );
  }
}
