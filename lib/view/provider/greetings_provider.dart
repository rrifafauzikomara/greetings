import 'package:flutter/material.dart';
import 'package:greetings/core/api/api_service.dart';
import 'package:greetings/core/config/config.dart';
import 'package:greetings/core/model/greetings.dart';

class GreetingsProvider with ChangeNotifier {
  final Config _config;
  late APiService _apiService;

  String? name;
  String? salutation;

  List<GreetingResponse> pastGreetings = [];

  GreetingsProvider(this._config) {
    _apiService = APiService(_config.greetingsUrl);
  }

  Future<void> greet(String? name) async {
    try {
      final greetingResponse = await _apiService.getGreeting(name);
      pastGreetings.add(greetingResponse);
      this.name = greetingResponse.name;
      salutation = greetingResponse.salutation;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }
}
