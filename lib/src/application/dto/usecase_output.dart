import 'dart:convert';

enum UseCaseOutputType {
  failure,
  success,
}

class UseCaseOutput {
  final UseCaseOutputType type;
  final String message;
  final dynamic data;

  const UseCaseOutput({
    required this.type,
    required this.message,
    required this.data,
  });

  factory UseCaseOutput.failure(String message, dynamic data) {
    return UseCaseOutput(
      type: UseCaseOutputType.failure,
      message: message,
      data: data,
    );
  }

  factory UseCaseOutput.success(String message, dynamic data) {
    return UseCaseOutput(
      type: UseCaseOutputType.success,
      message: message,
      data: data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'message': message,
      'data': data,
    };
  }

  String get toJson => json.encode(toMap());
}
