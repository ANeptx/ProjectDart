import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String typeuser;
  final String phone;
  UserModel({
    this.email,
    this.name,
    this.typeuser,
    this.phone,
  });

  UserModel copyWith({
    String email,
    String name,
    String typeuser,
    String phone,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      typeuser: typeuser ?? this.typeuser,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'typeuser': typeuser,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      typeuser: map['typeuser'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, typeuser: $typeuser, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      other.typeuser == typeuser &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      typeuser.hashCode ^
      phone.hashCode;
  }
  }
