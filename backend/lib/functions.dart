import 'dart:math';
import 'package:functions_framework/functions_framework.dart';
import 'greetings.dart';
// Export greetings so builder can use them when generating `bin/server.dart`.
export 'greetings.dart';

@CloudFunction()
GreetingResponse function(GreetingRequest request, RequestContext context) {
  final name = request.name ?? 'World';
  final response =
  GreetingResponse(salutation: _randomSalutation(), name: name);
  context.logger.info('greetingResponse: ${response.toJson()}');
  return response;
}

String _randomSalutation() => salutations[_random.nextInt(salutations.length)];

final _random = Random();

const salutations = [
  '안녕하세요', // annyeonghaseyo
  'こんにちは', // Kon'nichiwa
  '你好', // Nǐ hǎo
  'Привет', // Privet
  'สวัสดี', // S̄wạs̄dī
  'Aloha',
  'Bonjour',
  'Hello',
  'Ciao',
  'Dzień dobry',
  'Hola',
  'Hallo',
  'Kon’nichiwa',
  'Namaste',
  'Salam',
  'Shalom',
  'Tena koutou',
];