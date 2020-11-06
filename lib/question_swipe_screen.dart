import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'dart:math';

import 'package:keuzestress/theming.dart';

import 'answer_screen.dart';
import 'api/api_service.dart';
import 'api/question.dart';

class QuestionSwipeScreen extends StatefulWidget {
  @override
  _QuestionSwipeScreenState createState() => _QuestionSwipeScreenState();
}

class _QuestionSwipeScreenState extends State<QuestionSwipeScreen>
    with TickerProviderStateMixin {

  ApiService api = ApiService();
  Question question;
  Future<Question> futureQuestion;

  @override
  void initState() {
    super.initState();

    futureQuestion = api.fetchQuestion();
  }

  _pushOptionA() async {
    print("option A");
    await api.submitAnswer(question, question.optionAId);
    _goToResults();
  }

  _pushOptionB() async {
    print("option B");
    await api.submitAnswer(question, question.optionAId);
    _goToResults();
  }

  _pushSkipQuestion() async {
    print("skip");
    await api.submitAnswer(question, null);
    _goToResults();
  }

  _goToResults() async{
    futureQuestion =  api.fetchQuestion();
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return AnswerScreen(question.questionId);
            },
            maintainState: false));
  }


  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      body: new SafeArea(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(64.0, 64.0, 32.0, 0.0),
                child: Text(
                  "Vraag",
                  style: Theme.of(context).textTheme.headline5,
                )),
            questionBuilder(controller),
          ],
        ),
      ),
    );
  }

  Widget questionBuilder(CardController controller) {
    return FutureBuilder<Question>(
        future: futureQuestion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            question = snapshot.data;
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none, //allows positioning the question outside bounds
                  children: <Widget>[
                    Container(
                      // influences height above cards stack
                      height: MediaQuery.of(context).size.width * 1.2,
                      padding: EdgeInsets.fromLTRB(0,0,0, 52),
                      child: new TinderSwapCard(
                        swipeUp: true,
                        swipeDown: true,
                        orientation: AmassOrientation.BOTTOM,
                        totalNum: 1,
                        stackNum: 3,
                        swipeEdge: 4.0,
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.width * 0.9,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        minHeight: MediaQuery.of(context).size.width * 0.8,
                        cardBuilder: (context, index) => Transform.rotate(
                            angle: -pi / 70.0,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.network(snapshot.data.imageUrl, fit: BoxFit.cover,),
                              ),
                            )),
                        cardController: controller = CardController(),
                        swipeUpdateCallback:
                            (DragUpdateDetails details, Alignment align) {
                          /// Get swiping card's alignment
                          if (align.x < 0) {
                            //Card is LEFT swiping
                          } else if (align.x > 0) {
                            //Card is RIGHT swiping
                          }
                        },
                        swipeCompleteCallback:
                            (CardSwipeOrientation orientation, int index) {
                          /// Get orientation & index of swiped card!
                        },
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 50,
                        right: 20,
                        child: Card(
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                                child: Text(snapshot.data.question))))
                  ],
                ),
                const SizedBox(height: 24,),
                Container(
                  width: 280,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget> [
                    RaisedButton(onPressed: _pushOptionA , child: Text(snapshot.data.optionA), color: OrakelColors.confirmColor),
                    RaisedButton(onPressed: _pushOptionB , child: Text(snapshot.data.optionB),color: OrakelColors.denyColor),
                    RaisedButton(onPressed: _pushSkipQuestion , child: Text("Overslaan"),color: OrakelColors.skipColor, textColor: Colors.black,),
                  ]),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5);
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }

}
