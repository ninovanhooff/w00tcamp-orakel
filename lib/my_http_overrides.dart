import 'dart:io';

/// A terrible client that ignores bad certificates
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    var client = super.createHttpClient(context);
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    return client;
  }
}