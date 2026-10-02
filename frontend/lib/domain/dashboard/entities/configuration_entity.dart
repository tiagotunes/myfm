import 'package:flutter/material.dart';

class ConfigurationEntity {
  final IconData icon;
  final String label;
  final String url;

  ConfigurationEntity({
    required this.icon,
    required this.label,
    required this.url,
  });
}

class ConfigurationWithCountEntity {
  final ConfigurationEntity configuration;
  final String count;

  ConfigurationWithCountEntity({
    required this.configuration,
    required this.count,
  });
}
