import '../models/food_item.dart';
import '../models/cart_item.dart';

class CartProvider {
  static final List<CartItemModel> _cartItems = [];

  static List<CartItemModel> get cartItems => _cartItems;

  static void addToCart(FoodItem foodItem, int quantity) {
    // Check if the item is already in the cart
    final existingIndex = _cartItems.indexWhere((item) => item.foodItem.id == foodItem.id);

    if (existingIndex != -1) {
      // Update quantity if item exists
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = CartItemModel(
        foodItem: existingItem.foodItem,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item if it doesn't exist
      _cartItems.add(CartItemModel(
        foodItem: foodItem,
        quantity: quantity,
      ));
    }
  }

  static void removeFromCart(FoodItem foodItem) {
    _cartItems.removeWhere((item) => item.foodItem.id == foodItem.id);
  }

  static void updateQuantity(FoodItem foodItem, int quantity) {
    final index = _cartItems.indexWhere((item) => item.foodItem.id == foodItem.id);
    if (index != -1) {
      _cartItems[index] = CartItemModel(
        foodItem: foodItem,
        quantity: quantity,
      );
    }
  }

  static double getSubtotal() {
    return _cartItems.fold(0, (sum, item) => sum + (item.foodItem.price * item.quantity));
  }

  static void clearCart() {
    _cartItems.clear();
  }
}
