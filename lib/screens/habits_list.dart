import 'package:flutter/material.dart';
import 'package:habits_app/provider/habits_provider.dart';
import 'package:habits_app/screens/add_habit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HabitsList extends ConsumerWidget {
  const HabitsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => (AddHabit()))),
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return Color.fromARGB(51, 96, 125, 139);
          }),
        ),
        child: Text("+ NEW HABIT"),
      ),
      appBar: AppBar(title: Text("Habits")),
      body: SingleChildScrollView(
        child: Column(children: [Rythm(), CustomHabitTile()]),
      ),
    );
  }
}

class Rythm extends StatefulWidget {
  const Rythm({super.key});

  @override
  State<Rythm> createState() => _RythmState();
}

class _RythmState extends State<Rythm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(51, 96, 125, 139),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color.fromARGB(89, 96, 125, 139), width: 0.7),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text("Your Rhythm"),
                  Text("LAST 30 DAYS", style: TextStyle(fontSize: 8)),
                ],
              ),
              Spacer(),
              Text("total days"),
            ],
          ),
          SizedBox(height: 18),
          Text("--...-.-.-.-.--...-.-.-.-.--...-.-.-.-.-"),
          Text("--...-.-.-.-.--...-.-.-.-.--...-.-.-.-.-"),
          Text("--...-.-.-.-.--...-.-.-.-.--...-.-.-.-.-"),
        ],
      ),
    );
    ;
  }
}

class CustomHabitTile extends StatefulWidget {
  const CustomHabitTile({super.key});

  @override
  State<CustomHabitTile> createState() => _CustomHabitTileState();
}

class _CustomHabitTileState extends State<CustomHabitTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(51, 96, 125, 139),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color.fromARGB(89, 96, 125, 139), width: 0.7),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.ac_unit_rounded),
              SizedBox(width: 8),
              Text("habit title"),
              Spacer(),
              Text("streak"),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Text("_________/\\____"),
              Spacer(),
              Text("M T W T F S S"),
            ],
          ),
        ],
      ),
    );
  }
}
