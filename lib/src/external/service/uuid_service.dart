import 'package:uuid/uuid.dart';

import '../../application/service/uuid_service_abstract.dart';

class UuidService implements UuidServiceAbstract {
  final _uuid = Uuid();

  @override
  String v4() {
    return _uuid.v4();
  }
}
