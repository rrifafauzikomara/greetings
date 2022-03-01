class GreetingRequest {
  GreetingRequest({
    required this.name,
  });

  final String? name;

  factory GreetingRequest.fromJson(Map<String, dynamic> json) =>
      GreetingRequest(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class GreetingResponse {
  GreetingResponse({
    required this.salutation,
    required this.name,
  });

  final String? salutation;
  final String? name;

  factory GreetingResponse.fromJson(Map<String, dynamic> json) =>
      GreetingResponse(
        salutation: json["salutation"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "salutation": salutation,
        "name": name,
      };
}
