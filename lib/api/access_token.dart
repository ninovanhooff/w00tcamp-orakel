import 'dart:convert';

import 'package:http/http.dart' as http;


class AccessToken {
  final String token;

  AccessToken({this.token});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
        token: json['access_token']
    );
  }
}

Future<AccessToken> fetchToken() async {
  final response = await http.post(
    'https://noveesoft.eu.auth0.com/oauth/token',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'client_id': 'ZlWodgcuSYPLzzuMuxzwQvcbhlC8hITC',
      'client_secret': '0LyAiez9KAE5Wd3FkglS3SaN0nfrM-7ZwWnpyyEFqedV-SAwvScUfAMBhlwlxieJ',
      'audience': 'w00tcamp.orakel',
      'grant_type': 'client_credentials'
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AccessToken.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load token');
  }
}