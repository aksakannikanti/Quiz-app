import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/widgets/common/button.dart';
import 'package:quiz/widgets/game_screen/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlateGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.quiz,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Title
              const Text(
                'Quiz Master',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Subtitle
              Text(
                'Test your knowledge with fun questions',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 60),
              
              // Simple Features List
              _buildFeature('🎯', '10 Questions'),
              const SizedBox(height: 16),
              _buildFeature('⚡', 'True/False Format'),
              const SizedBox(height: 16),
              _buildFeature('🏆', 'Instant Results'),
              
              const Spacer(),
              
              // Start Button
              Container(
                width: double.infinity,
                child: Button(
                  buttonLabel: 'Start Quiz',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String emoji, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}