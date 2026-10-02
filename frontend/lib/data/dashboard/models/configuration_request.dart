import 'package:my_fm/core/configs/constants/api_url.dart';

abstract class ConfigurationRequest {
  final String url;
  ConfigurationRequest({required this.url});
}

class FederationRequest extends ConfigurationRequest {
  final String? id;
  final String acronym;
  final String name;

  FederationRequest({
    super.url = ApiUrl.federationsCtrl,
    this.id,
    required this.acronym,
    required this.name,
  });
}
