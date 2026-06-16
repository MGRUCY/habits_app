import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/add_habit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habits',
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepBlue),
      
      home: AddHabit(),
    );
  }
}
