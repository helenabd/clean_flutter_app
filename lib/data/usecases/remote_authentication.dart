import '../../domain/domain.dart';
import '../data.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });
  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}
