import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.numberOfAnsweredQuestions,
    required this.totalNumberOfQuestions,
  });

  final int numberOfAnsweredQuestions;
  final int totalNumberOfQuestions;

  @override
  Widget build(BuildContext context) {
    double progress = (numberOfAnsweredQuestions + 1) / totalNumberOfQuestions;

    return Column(
      children: [
        // Progress Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${numberOfAnsweredQuestions + 1}/$totalNumberOfQuestions',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Progress Bar
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.darkSlateBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Progress
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}