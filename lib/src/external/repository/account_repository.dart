import 'package:hive/hive.dart';

import '../../application/repository/account_repository_abstract.dart';

class AccountRepository implements AccountRepositoryAbstract {
  final String _boxName = 'accounts';

  Future<Box<Map<String, dynamic>>> _openBox() => Hive.openBox(_boxName);

  @override
  Future<void> add(Map<String, dynamic> account) async {
    final box = await _openBox();
    box.put(account['email'], account);
  }

  @override
  Future<Map<String, dynamic>> find(String email) async {
    final box = await _openBox();
    return Map<String, dynamic>.from(box.get(email) ?? {});
  }
}
