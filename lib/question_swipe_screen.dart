import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'dart:math';

import 'package:keuzestress/theming.dart';

import 'api/api_service.dart';
import 'api/question.dart';

class QuestionSwipeScreen extends StatefulWidget {
  @override
  _QuestionSwipeScreenState createState() => _QuestionSwipeScreenState();
}

class _QuestionSwipeScreenState extends State<QuestionSwipeScreen>
    with TickerProviderStateMixin {

  ApiService api = ApiService();
  Future<Question> question;

  List<String> welcomeImages = [
    "assets/images/helene_fischer.jpg",
    "assets/images/mario.jpg",
    "assets/images/helene_fischer.jpg",
    "assets/images/mario.jpg",
    "assets/images/mario.jpg",
  ];

  @override
  void initState() {
    super.initState();

    question = api.fetchQuestion();
  }

  _pushOptionA() {
    print("option A");
  }

  _pushOptionB() {
    print("option B");
  }

  _pushSkipQuestion() {
    print("skip");
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
                    totalNum: welcomeImages.length,
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
                            child: Image.asset('${welcomeImages[index]}'),
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
                            child: questionBuilder())))
              ],
            ),
            const SizedBox(height: 24,),
            Container(
              width: 280,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget> [
                RaisedButton(onPressed: _pushOptionA , child: Text("Hallo"), color: OrakelColors.confirmColor),
                RaisedButton(onPressed: _pushOptionB , child: Text("Hallo2"),color: OrakelColors.denyColor),
                RaisedButton(onPressed: _pushSkipQuestion , child: Text("Overslaan"),color: OrakelColors.skipColor, textColor: Colors.black,),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget questionBuilder() {
    return FutureBuilder<Question>(
        future: question,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.question);
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
