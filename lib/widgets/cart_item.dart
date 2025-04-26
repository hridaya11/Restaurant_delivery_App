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
            child: Image.asset(
              cartItem.foodItem.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
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
}
