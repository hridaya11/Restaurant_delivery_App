class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final List<String> addresses;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    this.addresses = const [],
  });
}
