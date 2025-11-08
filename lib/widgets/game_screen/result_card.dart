import 'package:flutter/material.dart';
import 'package:quiz/widgets/game_screen/base_card.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    required this.titleLabel,
    required this.isCorrect,
  });

  final String titleLabel;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      titleLabel: titleLabel,
      borderColor: isCorrect ? Colors.green : Colors.red,
      icon: isCorrect ? Icons.check_circle : Icons.cancel,
      iconColor: isCorrect ? Colors.green : Colors.red,
    );
  }
}