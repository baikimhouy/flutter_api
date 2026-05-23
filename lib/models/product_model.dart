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
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['title'] ?? 'No name',
      price: (json['price'] as num).toDouble(),
      rating:
          (json['rating']?['rate'] as num?)?.toDouble() ?? 0.0, 
      reviewCount:
          (json['rating']?['count'] as num?)?.toInt() ?? 0, 
      imageUrl: json['image'] ?? '', 
    );
  }
}
