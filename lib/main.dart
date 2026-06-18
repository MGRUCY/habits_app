import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_app/screens/habits_list.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("potato");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habits',
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.deepBlue),
      home: HabitsList()
      
    );
  }
}
