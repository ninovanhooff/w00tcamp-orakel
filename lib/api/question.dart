import 'dart:convert';

import 'package:http/http.dart' as http;

import 'access_token.dart';

Future<Question> fetchQuestion() async {
  final token = await fetchToken();
  final response = await http.get(
      'https://w00tcamp.orakel.noveesoft.com/api/question',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token.token}"
      }
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

class Question {
  final String title;

  Question({this.title});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        title: json['title']
    );
  }
}