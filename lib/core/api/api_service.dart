import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:greetings/core/model/greetings.dart';

class APiService {
  late Uri _uri;

  APiService(String uri) {
    _uri = Uri.parse(uri);
  }

  Future<GreetingResponse> getGreeting(String? name) async {
    final greetingRequest = GreetingRequest(name: name);

    final body = jsonEncode(greetingRequest.toJson());

    final res = await http.post(
      _uri,
      headers: {
        'content-type': 'application/json',
      },
      body: body,
    );

    if (res.statusCode == HttpStatus.ok) {
      final greetingResponse = GreetingResponse.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);
      return greetingResponse;
    }

    throw Exception(
        'Error: unexpected HTTP status code: ${res.statusCode.toString()}');
  }
}
