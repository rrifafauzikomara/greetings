import 'dart:convert';
import 'package:flutter/services.dart';

enum Environment {
  dev,
  prod,
}

extension EnumToString on Environment {
  String toName() => toString().split('.').last;
}

Environment parseEnvironment(String env) {
  switch (env) {
    case 'dev':
      return Environment.dev;
    case 'prod':
      return Environment.prod;
    default:
      throw Exception("Parsing as Environment enum exception: '$env'");
  }
}

class Config {
  final String greetingsUrl;

  Config({required this.greetingsUrl});

  static Future<Config> load(Environment env) async {
    final file = 'assets/config/${env.toName()}.json';
    final data = await rootBundle.loadString(file);
    final json = jsonDecode(data) as Map<String, dynamic>;
    return Config(greetingsUrl: json['greetingUrl'] as String);
  }

  static Future<Config> parse(String environment) async {
    final env = parseEnvironment(environment);
    return await load(env);
  }
}