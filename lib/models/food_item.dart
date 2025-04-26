class FoodItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final int deliveryTime;
  final double distance;
  final List<String> ingredients;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.distance,
    required this.ingredients,
  });
}
