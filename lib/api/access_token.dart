class AccessToken {
  final String token;

  AccessToken({this.token});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
        token: json['access_token']
    );
  }
}