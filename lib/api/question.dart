class Question {
  final String title;

  Question({this.title});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        title: json['title']
    );
  }
}