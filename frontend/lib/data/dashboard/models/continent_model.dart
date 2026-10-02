import 'package:my_fm/domain/dashboard/entities/continent_entity.dart';

class ContinentModel {
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContinentModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ContinentModel.fromMap(Map<String, dynamic> map) {
    return ContinentModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }
}

extension ContinentXModel on ContinentModel {
  ContinentEntity toEntity() {
    return ContinentEntity(
      id: id ?? '',
      name: name ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
    );
  }
}
