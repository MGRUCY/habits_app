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
            onPressed: () {},
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
              ),
              //fix
              itemBuilder: (context, index) {
                final status = statuses[index+1];
                return Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: (status != null)
                          ? color.withAlpha(140)
                          : Colors.grey.withAlpha(120),
                      width: 0.2,
                    ),
                  ),
                  height: 5,
                  width: 5,
                  child: //Text((status != null) ?
                  Text(
                    index.toString(),
                  ), //,style: TextStyle(color: color.withAlpha(120)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
