import 'food_item.dart';

class CartItemModel {
  final FoodItem foodItem;
  final int quantity;

  CartItemModel({
    required this.foodItem,
    required this.quantity,
  });
}
