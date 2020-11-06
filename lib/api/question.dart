class Question {
  final String questionId;
  final String question;
  final String imageUrl;
  final String optionA;
  final String optionAId;
  final String optionB;
  final String optionBId;

  Question({this.questionId, this.question, this.imageUrl, this.optionA, this.optionAId, this.optionB, this.optionBId});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionId: json['questionId'],
        question: json['question'],
        imageUrl: json['imageUrl'],
        optionA: json['questionOptions'][0]['text'],
        optionAId: json['questionOptions'][0]['optionId'],
        optionB: json['questionOptions'][1]['text'],
        optionBId: json['questionOptions'][1]['optionId'],
    );
  }
}