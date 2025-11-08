import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/widgets/game_screen/quiz.dart';

import '../../models/question.dart';
import '../../services/quiz_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key}); // FIX: Added const constructor and super.key

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isLoading = true; // FIX: Initialized
  List<Question> questions = []; // FIX: Initialized
  static const numberOfQuestions = 10;

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  void getQuestions() async {
    setState(() {
      isLoading = true;
    });

    final fetchedQuestions = await QuizService().getQuestions(numberOfQuestions);

    if (fetchedQuestions.isEmpty) { // FIX: Check for empty list instead of null
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ooops!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            TextButton( // FIX: Replaced FlatButton with TextButton
              child: const Text('Try again'),
              onPressed: () {
                Navigator.pop(context);
                getQuestions();
              },
            ),
          ],
          backgroundColor: AppColors.dodgerBlue,
        ),
      );
    } else {
      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Quiz(
                questions: questions,
              ),
      ),
    );
  }
}