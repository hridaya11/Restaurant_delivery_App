import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../utils/theme.dart';
import '../data/cart_provider.dart';
import 'counter.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;
  final VoidCallback onUpdate;

  const CartItem({
    Key? key,
    required this.cartItem,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 80,
              height: 80,
              child: _buildImageOrFallback(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.foodItem.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${cartItem.foodItem.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Counter(
                      value: cartItem.quantity,
                      onIncrement: () {
                        CartProvider.updateQuantity(cartItem.foodItem, cartItem.quantity + 1);
                        onUpdate();
                      },
                      onDecrement: () {
                        if (cartItem.quantity > 1) {
                          CartProvider.updateQuantity(cartItem.foodItem, cartItem.quantity - 1);
                          onUpdate();
                        }
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        CartProvider.removeFromCart(cartItem.foodItem);
                        onUpdate();
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOrFallback() {
    try {
      return Image.asset(
        cartItem.foodItem.imageUrl,
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
        child: Icon(
          _getCategoryIcon(),
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (cartItem.foodItem.category) {
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
    switch (cartItem.foodItem.category) {
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
