import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../application/service/hash_service_abstract.dart';
import '../../domain/config/hash_config.dart';

class HashService implements HashServiceAbstract {
  @override
  String hmac(String data, String salt) {
    var key = utf8.encode(HashConfig.secret);
    var bytes = utf8.encode('$data#$salt');
    var hmac = Hmac(sha256, key);
    var digest = hmac.convert(bytes);
    return digest.toString();
  }
}
