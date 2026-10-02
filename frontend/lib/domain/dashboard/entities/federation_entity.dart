import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';

class FederationEntity extends ConfigurationGenericEntity {
  final String id;
  final String acronym;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  FederationEntity({
    required this.id,
    required this.acronym,
    required this.name,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  String get title => acronym;
  
  @override
  String get subtitle => name;

  @override
  String get searchableText => '$acronym $name';
}
