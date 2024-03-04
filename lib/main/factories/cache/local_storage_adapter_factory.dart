import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../infra/cache/cahe.dart';

LocalStorageAdapter makeLocalStorageAdapter() =>
    LocalStorageAdapter(secureStorage: const FlutterSecureStorage());
