import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourguard/features/auth/domain/entities/user.dart';


class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.phoneNumber,
    required super.createdAt,
    super.updatedAt,
  });

  /// Factory method to create a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() : null,
    );
  }

  /// Converts the [UserModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  /// Override `toString` for debugging purposes.
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  /// Creates a copy of the current [UserModel] with updated values.
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
