import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/widgets/common/button.dart';
import 'package:quiz/widgets/game_screen/answer_card.dart';
import 'package:quiz/widgets/game_screen/progress_bar.dart';
import 'package:quiz/widgets/game_screen/result_card.dart';
import 'package:quiz/widgets/result_screen/result_screen.dart';

class Quiz extends StatefulWidget {
  final List<Question> questions;

  const Quiz({required this.questions});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  static const delayDuration = 2;

  int questionIndex = 0;
  String questionText = '';
  int numberOfCorrectAnswers = 0;
  String selectedAnswer = '';
  bool isDelayActive = false;
  bool isTrueCorrectAnswer = false;

  int get numberOfQuestions => widget.questions.length;

  @override
  void initState() {
    super.initState();
    _loadCurrentQuestion();
  }

  void _loadCurrentQuestion() {
    questionText = widget.questions[questionIndex].question;
  }

  void updateQuiz() async {
    if (selectedAnswer.isEmpty) {
      return;
    }

    String correctAnswer = widget.questions[questionIndex].correctAnswer;
    isTrueCorrectAnswer = correctAnswer.toLowerCase() == 'true';

    bool isPlayerCorrect = selectedAnswer == correctAnswer.toLowerCase();
    if (isPlayerCorrect) {
      numberOfCorrectAnswers++;
    }

    setState(() {
      isDelayActive = true;
    });

    await Future.delayed(const Duration(seconds: delayDuration));

    // Move to next question after delay
    if (questionIndex + 1 < widget.questions.length) {
      setState(() {
        questionIndex++;
        _loadCurrentQuestion();
        selectedAnswer = '';
        isDelayActive = false;
      });
    } else {
      // All questions completed - show results
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ResultScreen(
            numberOfCorrectAnswers: numberOfCorrectAnswers,
            numberOfQuestions: numberOfQuestions,
          ),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlateGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Progress Bar - Show current question, not next one
              ProgressBar(
                numberOfAnsweredQuestions: questionIndex,
                totalNumberOfQuestions: numberOfQuestions,
              ),
              
              const SizedBox(height: 30),
              
              // Question Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.darkSlateBlue,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Question Number - Show current question
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          'Question ${questionIndex + 1}/$numberOfQuestions',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Question Text
                      Text(
                        questionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Answers Section
                      Column(
                        children: [
                          isDelayActive
                              ? ResultCard(
                                  titleLabel: 'True',
                                  isCorrect: isTrueCorrectAnswer,
                                )
                              : AnswerCard(
                                  titleLabel: 'True',
                                  isSelected: selectedAnswer == 'true',
                                  onTap: () => setSelectedAnswer('true'),
                                ),
                          const SizedBox(height: 16),
                          isDelayActive
                              ? ResultCard(
                                  titleLabel: 'False',
                                  isCorrect: !isTrueCorrectAnswer,
                                )
                              : AnswerCard(
                                  titleLabel: 'False',
                                  isSelected: selectedAnswer == 'false',
                                  onTap: () => setSelectedAnswer('false'),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Next Button - Show appropriate text
              Button(
                buttonLabel: questionIndex == numberOfQuestions - 1 ? 'Finish Quiz' : 'Next Question',
                onPressed: selectedAnswer.isNotEmpty && !isDelayActive ? updateQuiz : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setSelectedAnswer(String text) {
    setState(() {
      selectedAnswer = text;
    });
  }
}