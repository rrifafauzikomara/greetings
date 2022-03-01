import 'package:backend/functions.dart' as function_library;
import 'package:functions_framework/serve.dart';

Future<void> main(List<String> args) async {
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) {
  switch (name) {
    case 'function':
      return JsonWithContextFunctionTarget(
        function_library.function,
        (json) {
          if (json is Map<String, dynamic>) {
            try {
              return function_library.GreetingRequest.fromJson(json);
            } catch (e, stack) {
              throw BadRequestException(
                400,
                'There was an error parsing the provided JSON data.',
                innerError: e,
                innerStack: stack,
              );
            }
          }
          throw BadRequestException(
            400,
            'The provided JSON is not the expected type '
            '`Map<String, dynamic>`.',
          );
        },
      );
    default:
      return null;
  }
}
