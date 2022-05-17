abstract class AccountRepositoryAbstract {
  Future<void> add(Map<String, dynamic> account);
  Future<Map<String, dynamic>> find(String email);
}
