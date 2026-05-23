class BannerModel {
  final String tag;
  final String title;
  final String subtitle;
  final String buttonText;
  final String? imageUrl; // network (optional)
  final String? assetImage; // local asset (optional)

  const BannerModel({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.imageUrl,
    this.assetImage,
  });
}
