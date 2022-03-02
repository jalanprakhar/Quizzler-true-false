import 'package:flutter/material.dart';
import './question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());
QuestionBrain q = QuestionBrain();

class Quizzler extends StatelessWidget {
  Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  // int finalscore = 0;
  // List<bool> answers = [false, true, true];

  int score = 0;
  void checkAnswer(bool chosen) {
    if (q.valid() && q.getAnswer(q.getQuestionNumber()) == chosen) {
      setState(() {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
        q.nextQuestion();
      });
      score++;
    } else {
      setState(() {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        q.nextQuestion();
      });
    }
    if (q.isFinished() == true) {
      setState(() {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz with a score of $score',
        ).show();
        q.reset();
        scoreKeeper = [];
        score = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                q.valid() ? q.getQuestionText(q.getQuestionNumber()) : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                }),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}


/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
