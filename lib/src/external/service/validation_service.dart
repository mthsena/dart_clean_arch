import '../../application/error/output_error.dart';
import '../../application/service/validation_service_abstract.dart';
import '../../domain/config/email_config.dart';
import '../../domain/config/hash_config.dart';
import '../../domain/config/password_config.dart';
import '../../domain/config/uuid_config.dart';

class ValidationService implements ValidationServiceAbstract {
  const ValidationService(this._messages);

  final List<String> _messages;

  @override
  ValidationService checkEmail(String email) {
    if (email.isEmpty) {
      _messages.add(EmailConfig.emptyError);
    }
    if (!email.contains(EmailConfig.symbol) || !email.contains(EmailConfig.domain)) {
      _messages.add(EmailConfig.formatError);
    }
    return this;
  }

  @override
  ValidationService checkPassword(String password) {
    if (password.isEmpty) {
      _messages.add(PasswordConfig.emptyError);
    }
    if (password.length < PasswordConfig.minLength) {
      _messages.add(PasswordConfig.lengthError);
    }
    return this;
  }

  @override
  ValidationService checkUuid(String uuid) {
    if (uuid.isEmpty) {
      _messages.add(UuidConfig.emptyError);
    }
    if (!RegExp(r'/^[0-9A-F]{8}-[0-9A-F]{4}-[4][0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i').hasMatch(uuid)) {
      _messages.add(UuidConfig.formatError);
    }
    return this;
  }

  @override
  ValidationService checkHash(String hash) {
    if (hash.isEmpty) {
      _messages.add(HashConfig.emptyError);
    }
    if (!RegExp(r'^[A-Fa-f0-9]{64}$').hasMatch(hash)) {
      _messages.add(HashConfig.formatError);
    }
    return this;
  }

  @override
  void validate() {
    if (_messages.isNotEmpty) throw OutputError(_messages.join(','));
  }
}
