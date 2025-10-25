import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
     String? avatar,
    String? phone,
  }) : super(
         id: id,
         email: email,
         firstName: firstName,
         lastName: lastName,
         avatar: avatar,
         phone: phone,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar,
    'phone': phone,
  };
}
