import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../utils/theme.dart';

class PopularFoodItem extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onTap;

  const PopularFoodItem({
    Key? key,
    required this.foodItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Hero(
                tag: 'food_image_${foodItem.id}',
                child: _buildFoodImage(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        foodItem.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${foodItem.deliveryTime} min',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentColor,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodImage(BuildContext context) {
    // Fixed height container to prevent infinite constraints
    return Container(
      height: 120,
      width: double.infinity,
      child: _buildImageOrFallback(),
    );
  }

  Widget _buildImageOrFallback() {
    try {
      return Image.asset(
        foodItem.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage();
        },
      );
    } catch (e) {
      return _buildFallbackImage();
    }
  }

  Widget _buildFallbackImage() {
    return Container(
      color: _getCategoryColor(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(),
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              foodItem.category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (foodItem.category) {
      case 'Pizza':
        return Colors.redAccent;
      case 'Burger':
        return Colors.orangeAccent;
      case 'Pasta':
        return Colors.amberAccent;
      case 'Dessert':
        return Colors.pinkAccent;
      case 'Drinks':
        return Colors.blueAccent;
      default:
        return AppTheme.secondaryColor;
    }
  }

  IconData _getCategoryIcon() {
    switch (foodItem.category) {
      case 'Pizza':
        return Icons.local_pizza;
      case 'Burger':
        return Icons.lunch_dining;
      case 'Pasta':
        return Icons.dinner_dining;
      case 'Dessert':
        return Icons.icecream;
      case 'Drinks':
        return Icons.local_drink;
      default:
        return Icons.fastfood;
    }
  }
}
