import '../config/account_config.dart';
import '../valueobject/email.dart';

class Account {
  const Account({
    required this.uuid,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  final String uuid;
  final Email email;
  final String password;
  final DateTime createdAt;

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      uuid: map['uuid'] ?? '',
      email: Email(
        address: map['email'] ?? '',
      ),
      password: map['password'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? AccountConfig.invalidDate),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'email': email.address,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Account copyWith({
    String? uuid,
    Email? email,
    String? password,
    DateTime? createdAt,
  }) {
    return Account(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
