import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';

class ContinentEntity extends ConfigurationGenericEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ContinentEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  String get icon => '${name.replaceAll(RegExp(' '), '').toLowerCase()}.svg';

  @override
  String get title => name;

  @override
  String get subtitle => '';

  @override
  String get searchableText => name;
}
