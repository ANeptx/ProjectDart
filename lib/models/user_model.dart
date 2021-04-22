import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String typeuser;
  final String phone;
  final String password;
  final String address;
  final String gender;
  UserModel({
    this.email,
    this.name,
    this.typeuser,
    this.phone,
    this.password,
    this.address,
    this.gender,
  });
  

  UserModel copyWith({
    String email,
    String name,
    String typeuser,
    String phone,
    String password,
    String address,
    String gender,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      typeuser: typeuser ?? this.typeuser,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'typeuser': typeuser,
      'phone': phone,
      'password': password,
      'address': address,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      typeuser: map['typeuser'],
      phone: map['phone'],
      password: map['password'],
      address: map['address'],
      gender: map['gender'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, typeuser: $typeuser, phone: $phone, password: $password, address: $address, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      other.typeuser == typeuser &&
      other.phone == phone &&
      other.password == password &&
      other.address == address &&
      other.gender == gender;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      typeuser.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      address.hashCode ^
      gender.hashCode;
  }
  }
