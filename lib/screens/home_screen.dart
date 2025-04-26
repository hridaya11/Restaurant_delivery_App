import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/food_category.dart';
import '../widgets/popular_food_item.dart';
import '../widgets/custom_drawer.dart';
import '../data/food_data.dart';
import 'food_detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildWelcomeSection(),
                      const SizedBox(height: 24),
                      _buildSearchBar(),
                      const SizedBox(height: 24),
                      _buildCategorySection(),
                      const SizedBox(height: 24),
                      _buildPopularSection(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: AppTheme.textColor),
            ),
          ),
          Text(
            'Tasty Bites',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const CartScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.shopping_cart, color: AppTheme.textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, John!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'What would you like to eat today?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for food...',
          hintStyle: TextStyle(color: AppTheme.lightTextColor),
          prefixIcon: Icon(Icons.search, color: AppTheme.lightTextColor),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              FoodCategory(
                title: 'All',
                icon: Icons.fastfood,
                isSelected: _selectedCategory == 'All',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'All';
                  });
                },
              ),
              FoodCategory(
                title: 'Pizza',
                icon: Icons.local_pizza,
                isSelected: _selectedCategory == 'Pizza',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Pizza';
                  });
                },
              ),
              FoodCategory(
                title: 'Burger',
                icon: Icons.lunch_dining,
                isSelected: _selectedCategory == 'Burger',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Burger';
                  });
                },
              ),
              FoodCategory(
                title: 'Pasta',
                icon: Icons.dinner_dining,
                isSelected: _selectedCategory == 'Pasta',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Pasta';
                  });
                },
              ),
              FoodCategory(
                title: 'Dessert',
                icon: Icons.icecream,
                isSelected: _selectedCategory == 'Dessert',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Dessert';
                  });
                },
              ),
              FoodCategory(
                title: 'Drinks',
                icon: Icons.local_drink,
                isSelected: _selectedCategory == 'Drinks',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'Drinks';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularSection() {
    // Filter food items based on selected category
    final filteredItems = _selectedCategory == 'All'
        ? mockFoodItems
        : mockFoodItems.where((item) => item.category == _selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedCategory == 'All' ? 'Popular Items' : _selectedCategory,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        filteredItems.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.no_food,
                        size: 64,
                        color: AppTheme.lightTextColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No items found in this category',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.lightTextColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return PopularFoodItem(
                    foodItem: filteredItems[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => FoodDetailScreen(
                            foodItem: filteredItems[index],
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  );
                },
              ),
      ],
    );
  }
}
