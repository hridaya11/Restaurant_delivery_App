import '../models/user.dart';

class AuthProvider {
  static User? _currentUser;
  static bool _isLoggedIn = false;

  // Mock user database
  static final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'password': 'password123',
      'phone': '+1234567890',
      'addresses': ['123 Main St, New York, NY 10001'],
    },
  ];

  static User? get currentUser => _currentUser;
  static bool get isLoggedIn => _isLoggedIn;

  // Login method
  static Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Find user with matching email and password
    final userMap = _users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (userMap.isNotEmpty) {
      _currentUser = User(
        id: userMap['id'],
        name: userMap['name'],
        email: userMap['email'],
        phone: userMap['phone'],
        addresses: List<String>.from(userMap['addresses']),
      );
      _isLoggedIn = true;
      return true;
    }

    return false;
  }

  // Register method
  static Future<bool> register(String name, String email, String password, String phone) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if email already exists
    final existingUser = _users.any((user) => user['email'] == email);
    if (existingUser) {
      return false;
    }

    // Create new user
    final newUserId = (_users.length + 1).toString();
    final newUser = {
      'id': newUserId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'addresses': <String>[],
    };

    _users.add(newUser);

    // Auto login after registration
    _currentUser = User(
      id: newUserId,
      name: name,
      email: email,
      phone: phone,
    );
    _isLoggedIn = true;

    return true;
  }

  // Logout method
  static Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _isLoggedIn = false;
  }

  // Check if user exists with email
  static Future<bool> checkUserExists(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users.any((user) => user['email'] == email);
  }

  // Reset password (mock implementation)
  static Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.any((user) => user['email'] == email);
  }
}
