import '../../domain/config/account_config.dart';
import '../../domain/entity/account.dart';
import '../../domain/usecase/usecase_abstract.dart';
import '../../domain/valueobject/email.dart';
import '../dto/account_input.dart';
import '../dto/usecase_output.dart';
import '../error/output_error.dart';
import '../repository/account_repository_abstract.dart';
import '../service/hash_service_abstract.dart';
import '../service/validation_service_abstract.dart';

class SignInAccountUseCase implements UseCaseAbstract<AccountInput, UseCaseOutput> {
  const SignInAccountUseCase(
    this._accountRepository,
    this._hashService,
    this._validationService,
  );

  final AccountRepositoryAbstract _accountRepository;
  final HashServiceAbstract _hashService;
  final ValidationServiceAbstract _validationService;

  @override
  Future<UseCaseOutput> execute(AccountInput input) async {
    try {
      _validationService.checkEmail(input.email).checkPassword(input.password);
      final passwordHash = _hashService.hmac(input.password, input.email);
      _validationService.checkHash(passwordHash);
      final email = Email(
        address: input.email,
      );
      _validationService.validate();
      final accountData = await _accountRepository.find(email.address);
      final account = Account.fromMap(accountData);
      if (passwordHash != account.password) throw OutputError(AccountConfig.authenticationInvalid);
      return UseCaseOutput.success(AccountConfig.authenticationSuccess, account.toMap());
    } on OutputError catch (e) {
      return UseCaseOutput.failure(AccountConfig.authenticationError, e.message);
    }
  }
}
