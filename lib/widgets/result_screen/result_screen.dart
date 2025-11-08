import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/widgets/common/button.dart';
import 'package:quiz/widgets/home_screen/home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    required this.numberOfCorrectAnswers,
    required this.numberOfQuestions,
  });

  final int numberOfCorrectAnswers;
  final int numberOfQuestions;

  double get scorePercentage => (numberOfCorrectAnswers / numberOfQuestions) * 100;

  String get performanceText {
    if (scorePercentage >= 80) return 'Excellent! 🎉';
    if (scorePercentage >= 60) return 'Good Job! 👍';
    if (scorePercentage >= 40) return 'Not Bad! 😊';
    return 'Keep Trying! 💪';
  }

  Color get performanceColor {
    if (scorePercentage >= 80) return AppColors.green;
    if (scorePercentage >= 60) return AppColors.amber;
    if (scorePercentage >= 40) return AppColors.dodgerBlue;
    return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1E2D),
              Color(0xFF2D2D44),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header
                const SizedBox(height: 20),
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  performanceText,
                  style: TextStyle(
                    fontSize: 20,
                    color: performanceColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const Spacer(),
                
                // Score Circle
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle
                      Container(
                        width: 180,
                        height: 180,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.darkSlateGray,
                        ),
                      ),
                      
                      // Score content
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$numberOfCorrectAnswers',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'out of $numberOfQuestions',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: performanceColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${scorePercentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: 14,
                                color: performanceColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Stats
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkSlateBlue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Correct', numberOfCorrectAnswers, AppColors.green),
                      _buildStatItem('Wrong', numberOfQuestions - numberOfCorrectAnswers, AppColors.red),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Action Buttons
                Column(
                  children: [
                    Button(
                      buttonLabel: 'Play Again',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const HomeScreen(),
                            transitionsBuilder: (_, animation, __, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        // Share functionality can be added here
                      },
                      child: const Text(
                        'Share Results',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}