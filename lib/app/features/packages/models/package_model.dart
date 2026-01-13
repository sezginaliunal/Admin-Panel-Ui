class PackageModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final List<String> features;
  final bool isPopular;
  final String color;

  PackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.features,
    this.isPopular = false,
    required this.color,
  });
}
