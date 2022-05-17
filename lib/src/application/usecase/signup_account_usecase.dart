import '../../domain/config/account_config.dart';
import '../../domain/entity/account.dart';
import '../../domain/usecase/usecase_abstract.dart';
import '../../domain/valueobject/email.dart';
import '../dto/account_input.dart';
import '../dto/usecase_output.dart';
import '../error/output_error.dart';
import '../repository/account_repository_abstract.dart';
import '../service/hash_service_abstract.dart';
import '../service/uuid_service_abstract.dart';
import '../service/validation_service_abstract.dart';

class SignUpAccountUseCase implements UseCaseAbstract<AccountInput, UseCaseOutput> {
  const SignUpAccountUseCase(
    this._accountRepository,
    this._hashService,
    this._uuidService,
    this._validationService,
  );

  final AccountRepositoryAbstract _accountRepository;
  final HashServiceAbstract _hashService;
  final UuidServiceAbstract _uuidService;
  final ValidationServiceAbstract _validationService;

  @override
  Future<UseCaseOutput> execute(AccountInput input) async {
    try {
      _validationService.checkEmail(input.email).checkPassword(input.password);
      final uuid = _uuidService.v4();
      final passwordHash = _hashService.hmac(input.password, input.email);
      _validationService.checkUuid(uuid).checkHash(passwordHash);
      final account = Account(
        uuid: uuid,
        email: Email(
          address: input.email,
        ),
        password: passwordHash,
        createdAt: DateTime.now(),
      );
      _validationService.validate();
      await _accountRepository.add(account.toMap());
      return UseCaseOutput.success(AccountConfig.creationSuccess, account.toMap());
    } on OutputError catch (e) {
      return UseCaseOutput.failure(AccountConfig.creationError, e.message);
    }
  }
}
