class Question {
  final String question;
  final String imageUrl;

  Question({this.question, this.imageUrl});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'],
        imageUrl: json['imageUrl']
    );
  }
}