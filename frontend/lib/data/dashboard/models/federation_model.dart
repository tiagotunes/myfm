import 'package:my_fm/domain/dashboard/entities/federation_entity.dart';

class FederationModel {
  final String? id;
  final String? acronym;
  final String? name;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FederationModel({
    this.id,
    this.acronym,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory FederationModel.fromMap(Map<String, dynamic> map) {
    return FederationModel(
      id: map['id'] != null ? map['id'] as String : null,
      acronym: map['acronym'] != null ? map['acronym'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }
}

extension FederationXModel on FederationModel {
  FederationEntity toEntity() {
    return FederationEntity(
      id: id ?? '',
      acronym: acronym ?? '',
      name: name ?? '',
      isActive: isActive ?? false,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
    );
  }
}
