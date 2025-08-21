import 'package:flutter/material.dart';
import 'app_colors.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  const ResultPage({super.key, required this.bmi});

  String get status => bmi >= 25
      ? 'Overweight'
      : bmi > 18.5
          ? 'Normal'
          : 'Underweight';

  String get message => bmi >= 25
      ? 'You have a higher than normal body weight.'
      : bmi > 18.5
          ? 'Your weight is absolutely normal. Good job!'
          : 'You have a lower than normal body weight.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result'), centerTitle: true),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(status, style: const TextStyle(fontSize: 22, color: AppColors.textPrimary)),
              Text(bmi.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent)),
              Text(message,
                  style: const TextStyle(color: AppColors.textSecondary),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Recalculate'),
              )
            ],
          ),
        ),
      ),
    );
  }
}