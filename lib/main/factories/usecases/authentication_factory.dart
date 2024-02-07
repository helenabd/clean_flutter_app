import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
    httpClient: makeHttpAdapter(),
    url: makeAPIUrl('login'),
  );
}
