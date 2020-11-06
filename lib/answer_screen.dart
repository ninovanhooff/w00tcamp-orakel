import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'dart:math';

import 'package:keuzestress/theming.dart';

class AnswerScreen extends StatefulWidget {
  final questionId;

  AnswerScreen(this.questionId);

  @override
  _AnswerScreenState createState() => _AnswerScreenState(questionId);
}

class _AnswerScreenState extends State<AnswerScreen>
    with TickerProviderStateMixin {

  String questionId;

  _AnswerScreenState(this.questionId);

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      body: new SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(64.0, 64.0, 32.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Antwoord",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Dit zijn de antwoorden naar leeftijd",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Bar("<20", 0.2),
                  Bar("20-35", 0.5),
                  Bar("36-50", 0.7),
                  Bar(">50", 0.4),
                ],
              ),
              SizedBox(height: 60),
              Text(
                "70% van van de mannen  die gestemd hebben, hebben 'Ja natuurlijk' gestend",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final double amount;
  final String label;

  const Bar(this.label, this.amount, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // space between bar and label
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          width: 30,
          height: 150,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter, // 10% of the width, so there are ten blinds.
              colors: [
                OrakelColors.answerBarFilledColor,
                OrakelColors.answerBarFilledColor,
                OrakelColors.answerBarEmptyColor,
              ], // red to yellow
              stops: [0.0, amount, amount],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
        ),
        Text(label,
          style: TextStyle(fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}
