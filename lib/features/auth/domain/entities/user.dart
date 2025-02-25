class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.createdAt,
    this.updatedAt,
  });
}


