import 'package:flutter/material.dart';
import 'result_page.dart';
import 'app_colors.dart';

void main() => runApp(const BMIApp());

class BMIApp extends StatelessWidget {
  const BMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.accent,
          thumbColor: AppColors.accent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textPrimary,
          ),
        ),
      ),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool isMale = true;
  double height = 180;
  int weight = 50, age = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                genderButton('Male', Icons.male, isMale),
                genderButton('Female', Icons.female, !isMale),
              ],
            ),
            card(
              child: Column(
                children: [
                  const Text('Height', style: TextStyle(color: AppColors.textPrimary)),
                  Text('${height.toInt()} cm',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.textPrimary,
                          )),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    onChanged: (v) => setState(() => height = v),
                  )
                ],
              ),
            ),
            Row(
              children: [
                numberAdjuster('Weight', weight, (v) => setState(() => weight = v)),
                numberAdjuster('Age', age, (v) => setState(() => age = v)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final bmi = weight / ((height / 100) * (height / 100));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultPage(bmi: bmi),
                  ),
                );
              },
              child: const Text('Calculate'),
            )
          ],
        ),
      ),
    );
  }

  Expanded genderButton(String label, IconData icon, bool active) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = label == 'Male'),
        child: card(
          color: active ? AppColors.accent : AppColors.card,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: AppColors.textPrimary),
              Text(label, style: const TextStyle(color: AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }

  Expanded numberAdjuster(String label, int value, ValueChanged<int> onChange) {
    return Expanded(
      child: card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textPrimary)),
            Text('$value',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => onChange(value - 1),
                    icon: const Icon(Icons.remove),
                    color: AppColors.textPrimary),
                IconButton(
                    onPressed: () => onChange(value + 1),
                    icon: const Icon(Icons.add),
                    color: AppColors.textPrimary),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget card({required Widget child, Color? color}) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}