import 'package:flutter/material.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/widgets/game_screen/base_card.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    required this.titleLabel,
    required this.isSelected,
    required this.onTap,
  });

  final String titleLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: BaseCard(
        titleLabel: titleLabel,
        borderColor: isSelected ? AppColors.primary : AppColors.darkSlateBlue,
        icon: isSelected ? Icons.check_circle : Icons.circle_outlined,
        iconColor: isSelected ? AppColors.primary : Colors.white.withOpacity(0.5),
        onTap: onTap,
      ),
    );
  }
}