import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_app/settings/habit_colors.dart';
import 'package:habits_app/settings/today_string.dart';
import 'package:intl/intl.dart';
import 'package:habits_app/provider/logs/habits_logs_provider.dart';

class HabitDetailsScreen extends ConsumerWidget {
  const HabitDetailsScreen(this.habit, this.streak, {super.key});

  final Map<String, dynamic> habit;
  final int streak;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(habitLogsProvider(habit["id"]));
    List<String?> statuses = logsAsync.maybeWhen(
      data: (logs) {
        return ref
            .read(habitLogsProvider(habit["id"]).notifier)
            .last30DaysStatus(logs);
      },
      orElse: () => List.filled(30, null),
    );
    int count = 0;

    statuses.nonNulls.map((status) {
      if (status == 'done') {
        count++;
      }
    }).toString();
    int countG = 0;
    statuses.nonNulls.map((status) {
      if (status == 'grace') {
        countG++;
      }
    }).toString();
    //times
    bool timesOrDays = habit['timesFlag'];
    String timesString = "${habit['timesPerWeekInt'].toString()} x / week";
    //days
    List<String> daysList = (habit['daysList'] as List?)?.cast<String>() ?? [];
    int daysCout = daysList.length;
    String daysString = "$daysCout days / week";
    String period = timesOrDays ? timesString : daysString;
    Color color = habitColors[habit['colorInt'] as int];
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(habit['createdAt'].toString()),
    );
    String date = DateFormat.yMEd().format(dateTime);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(habit['name'], style: TextStyle(color: color, fontSize: 24)),
            Text(
              "since $date - $period",
              style: TextStyle(color: Colors.grey.withAlpha(150), fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: ((context) => (AddHabit()))),
              // );
            },
            icon: Icon(
              Icons.edit_note_rounded,
              size: 35,
              color: color.withAlpha(180),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: .center,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: color.withAlpha(140), width: 0.7),
                ),
                height: 100,
                width: 100,
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [Text(streak.toString()), Text("Streak")],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: color.withAlpha(140), width: 0.7),
                ),
                height: 100,
                width: 100,
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Text(count.toString()),
                    Text("day / \n 30 days", textAlign: .center),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: color.withAlpha(140), width: 0.7),
                ),
                height: 100,
                width: 100,
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [Text(countG.toString()), Text("Grace days")],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          TextButton(
            onPressed: () {
              bool isDoneToday = false;
              String nonNullStatus = statuses.last ?? "";
              if (nonNullStatus.contains('done') ||
                  nonNullStatus.contains('grace')) {
                isDoneToday = true;
              }

              int habitId = habit['id'] as int;
              String today = todayString();
              final notifier = ref.read(habitLogsProvider(habitId).notifier);
              if (isDoneToday) {
                notifier.unmark(today);
              } else {
                notifier.markGrace(today);
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return color.withAlpha(80);
              }),
            ),
            child: Text("grace", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                final status = statuses[index];
                final int daysAgo = 29 - index;
                final DateTime dateForSquare = DateTime.now().subtract(
                  Duration(days: daysAgo),
                );
                final String dayString = dateForSquare.day.toString();

                Color fillColor;
                Color borderColor;
                Color textColor;

                if (status == 'done') {
                  fillColor = color;
                  borderColor = color;
                  textColor = Colors.white;
                } else if (status == 'grace') {
                  fillColor = color.withAlpha(100);
                  borderColor = color.withAlpha(100);
                  textColor = Colors.white;
                } else {
                  fillColor = Colors.grey.withAlpha(40);
                  borderColor = Colors.grey.withAlpha(120);
                  textColor = const Color.fromARGB(137, 255, 255, 255);
                }

                return Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: borderColor, width: 0.7),
                  ),
                  child: Center(
                    child: Text(
                      dayString,
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: status == 'done'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
