import 'package:my_fm/data/dashboard/models/continent_model.dart';
import 'package:my_fm/data/dashboard/models/federation_model.dart';
import 'package:my_fm/domain/dashboard/entities/nation_entity.dart';

class NationModel {
  final String? id;
  final String? name;
  final String? demonym;
  final String? cca2;
  final String? region;
  final ContinentModel? continent;
  final FederationModel? federation;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NationModel({
    this.id,
    this.name,
    this.demonym,
    this.cca2,
    this.region,
    this.continent,
    this.federation,
    this.createdAt,
    this.updatedAt,
  });

  factory NationModel.fromMap(Map<String, dynamic> map) {
    return NationModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      demonym: map['demonym'] != null ? map['demonym'] as String : null,
      cca2: map['cca2'] != null ? map['cca2'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      continent: map['continent'] != null
          ? ContinentModel.fromMap(map['continent'] as Map<String, dynamic>)
          : null,
      federation: map['federation'] != null
          ? FederationModel.fromMap(map['federation'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }
}

extension NationXModel on NationModel {
  NationEntity toEntity() {
    return NationEntity(
      id: id ?? '',
      name: name ?? '',
      demonym: demonym ?? '',
      cca2: cca2 ?? '',
      region: region ?? '',
      continent: continent?.toEntity(),
      federation: federation?.toEntity(),
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
    );
  }
}
