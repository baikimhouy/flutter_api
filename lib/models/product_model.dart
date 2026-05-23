class ProductModel {
  final String id;
  final String name;
  final double price;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  bool isFavourite;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.isFavourite = false,
  });

  // API response shape:
  // {
  //   "id": 1,
  //   "title": "Product",
  //   "price": 100,
  //   "images": ["url1", "url2"],
  //   "category": { "name": "..." }
  // }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // images is a list of strings, grab the first valid one
    String imageUrl = '';
    final images = json['images'];
    if (images != null && images is List && images.isNotEmpty) {
      // API sometimes wraps URLs in [ ] brackets — clean them
      imageUrl = (images[0] as String)
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .trim();
    }

    return ProductModel(
      id: json['id'].toString(),
      name: json['title'] ?? 'No name',
      price: (json['price'] as num).toDouble(),
      rating: 4.5, // API has no rating — hardcoded for now
      reviewCount: 0, // API has no review count — hardcoded for now
      imageUrl: imageUrl,
    );
  }
}
