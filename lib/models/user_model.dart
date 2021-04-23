import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String phone;
  final String password;
  final String address;
  final String gender;
  final String uid;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.password,
    this.address,
    this.gender,
    this.uid,
  });
  

  UserModel copyWith({
    String email,
    String name,
    String phone,
    String password,
    String address,
    String gender,
    String uid,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      uid : uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
      'address': address,
      'gender': gender,
      'uid' : uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      password: map['password'],
      address: map['address'],
      gender: map['gender'],
      uid : map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, phone: $phone, password: $password, address: $address, gender: $gender , uid : $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      other.phone == phone &&
      other.password == password &&
      other.address == address &&
      other.gender == gender;
      
  }

  @override
  int get hashCode {
    return email.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      address.hashCode ^
      gender.hashCode;
  }
  }
