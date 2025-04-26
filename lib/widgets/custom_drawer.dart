import 'package:flutter/material.dart';
import '../utils/theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.secondaryColor,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'john.doe@example.com',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            isSelected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_bag,
            title: 'My Orders',
            onTap: () {
              Navigator.pop(context);
              // Navigate to orders screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.favorite,
            title: 'Favorites',
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorites screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.location_on,
            title: 'Delivery Address',
            onTap: () {
              Navigator.pop(context);
              // Navigate to address screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () {
              Navigator.pop(context);
              // Navigate to payment methods screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings screen
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.secondaryColor : AppTheme.textColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppTheme.secondaryColor : AppTheme.textColor,
            ),
      ),
      onTap: onTap,
      tileColor: isSelected ? AppTheme.primaryColor : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
