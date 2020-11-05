import 'package:keuzestress/api/access_token.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:keuzestress/api/question.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  AccessToken _token;

  factory ApiService() {
    return _singleton;
  }

  Future<AccessToken> _ensureToken() async {
    if (_token == null){
      _token = await fetchToken();
    }

    return _token;
  }

  Future<Question> fetchQuestion() async {
    final headers = await _defaultHeaders();

    final response = await http.get(
        'https://w00tcamp.orakel.noveesoft.com/api/question',
        headers: headers
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Question.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Question');
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

  _defaultHeaders() async {
    final token = await _ensureToken();

    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${token.token}"
    };
  }

  ApiService._internal();
}
