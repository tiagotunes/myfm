import 'package:my_fm/domain/dashboard/entities/configuration_generic_entity.dart';
import 'package:my_fm/domain/dashboard/entities/continent_entity.dart';
import 'package:my_fm/domain/dashboard/entities/federation_entity.dart';

class NationEntity extends ConfigurationGenericEntity {
  final String id;
  final String name;
  final String demonym;
  final String cca2;
  final String? region;
  final ContinentEntity? continent;
  final FederationEntity? federation;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NationEntity({
    required this.id,
    required this.name,
    required this.demonym,
    required this.cca2,
    this.region,
    this.continent,
    this.federation,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  String get icon => '${cca2.toLowerCase()}.svg';

  @override
  String get title => name;

  @override
  String get subtitle => cca2;

  @override
  String get searchableText =>
      '$name $cca2 $region ${continent?.name} ${federation?.acronym}';
}
