abstract class ValidationServiceAbstract {
  ValidationServiceAbstract checkEmail(String email);
  ValidationServiceAbstract checkPassword(String password);
  ValidationServiceAbstract checkUuid(String uuid);
  ValidationServiceAbstract checkHash(String hash);
  void validate();
}
