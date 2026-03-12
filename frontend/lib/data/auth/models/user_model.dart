import 'package:my_fm/domain/auth/entities/user_entity.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;

  UserModel({this.id, this.email, this.name});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString(),
      email: map['email']?.toString(),
      name: map['name']?.toString(),
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(id: id ?? '', email: email ?? '', name: name ?? '');
  }
}
