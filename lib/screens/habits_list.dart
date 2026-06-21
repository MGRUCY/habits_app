import 'package:flutter/material.dart';
import 'package:habits_app/screens/habit_details_screen.dart';
import 'package:habits_app/settings/habit_colors.dart';
import 'package:habits_app/provider/habits/habits_provider.dart';
import 'package:habits_app/provider/logs/habits_logs_provider.dart';
import 'package:habits_app/screens/add_habit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_app/settings/today_string.dart';

class HabitsList extends ConsumerWidget {
  const HabitsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);

    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => (AddEditHabit(null))),
            ), //add
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Rythm(),
            habitsAsync.when(
              data: (habits) {
                return Column(
                  children: habits.map((habit) {
                    return CustomHabitTile(habit: habit);
                  }).toList(),
                );
              },
              loading: () => Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Text("Error loading habits: $err"),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

class Rythm extends ConsumerStatefulWidget {
  const Rythm({super.key});

  @override
  ConsumerState<Rythm> createState() => _RythmState();
}

class _RythmState extends ConsumerState<Rythm> {
  @override
  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitsProvider);

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
            crossAxisAlignment: .start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Rhythm"),
                  Text("LAST 30 DAYS", style: TextStyle(fontSize: 8)),
                ],
              ),
              // Spacer(),
            ],
          ),
          SizedBox(height: 18),
          habitsAsync.when(
            data: (habits) {
              return Column(
                children: habits.map((habit) {
                  return _HabitDotsRow(habit: habit);
                }).toList(),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (err, stack) => Text("Error: $err"),
          ),
        ],
      ),
    );
  }
}

class _HabitDotsRow extends ConsumerWidget {
  final Map<String, dynamic> habit;
  const _HabitDotsRow({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color color = habitColors[habit['colorInt'] as int];
    int habitId = habit['id'] as int;
    final logsAsync = ref.watch(habitLogsProvider(habitId));

    List<String?> statuses = logsAsync.maybeWhen(
      data: (logs) {
        return ref
            .read(habitLogsProvider(habitId).notifier)
            .last30DaysStatus(logs);
      },
      orElse: () => List.filled(30, null),
    );

    List newList = statuses.reversed
        .toList()
        .getRange(0, 7)
        .toList()
        .reversed
        .toList();
    print("newList: $newList");

    List lineSpikes = newList.map((e) {
      if (e == "done") {
        return 1;
      } else {
        return 0;
      }
    }).toList();
    print("lineSpikes: $lineSpikes");

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: statuses.map((status) {
          Color dotColor;
          if (status == 'done') {
            dotColor = color;
          } else if (status == 'grace') {
            dotColor = color.withAlpha(110);
          } else {
            dotColor = color.withAlpha(30);
          }

          return Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
          );
        }).toList(),
      ),
    );
  }
}

class CustomHabitTile extends ConsumerStatefulWidget {
  final Map<String, dynamic> habit;
  const CustomHabitTile({super.key, required this.habit});

  @override
  ConsumerState<CustomHabitTile> createState() => _CustomHabitTileState();
}

class _CustomHabitTileState extends ConsumerState<CustomHabitTile> {
  @override
  Widget build(BuildContext context) {
    Color color = habitColors[widget.habit['colorInt'] as int];
    int habitId = widget.habit['id'] as int;
    final logsAsync = ref.watch(habitLogsProvider(habitId));
    String today = todayString();
    bool isLoading = logsAsync.isLoading;

    int streak = logsAsync.maybeWhen(
      data: (logs) {
        return ref
            .read(habitLogsProvider(habitId).notifier)
            .calculateStreak(logs);
      },
      orElse: () => 0,
    );
    String stringStreak = streak.toString();
    if (streak != 0) {
      stringStreak = "$streak 🔥";
    }
    String? todayStatus = logsAsync.maybeWhen(
      data: (logs) {
        return ref
            .read(habitLogsProvider(habitId).notifier)
            .statusForDate(logs, today);
      },
      orElse: () => null,
    );

    bool isDoneToday = false;
    if (todayStatus == 'done') {
      isDoneToday = true;
    }
    bool graceDay = false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => (HabitDetailsScreen(widget.habit, streak))),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withAlpha(140), width: 0.7),
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    if (isLoading) return;
                    final notifier = ref.read(
                      habitLogsProvider(habitId).notifier,
                    );
                    if (isDoneToday) {
                      notifier.unmark(today);
                    } else if (todayStatus == 'grace') {
                      todayStatus == 'grace'
                          ? graceDay = true
                          : graceDay = false;
                    } else {
                      notifier.markDone(today);
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDoneToday ? color : Colors.transparent,
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Icon(
                      Icons.check,
                      color: isDoneToday ? Colors.white : color.withAlpha(0),
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.habit['name'] ?? '',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Text(
                  stringStreak,
                  style: TextStyle(
                    color: color.withAlpha(190),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Text(
                  "_________/\\____", //edit
                  style: TextStyle(color: color, fontSize: 12),
                ),
                Spacer(),
                _buildDayLabels(color),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayLabels(Color color) {
    List<String> labels = ["M", "T", "W", "T", "F", "S", "S"];
    bool timesFlag = widget.habit['timesFlag'];
    List<String> daysList =
        (widget.habit['daysList'] as List?)?.cast<String>() ?? [];

    return Row(
      children: [
        for (int i = 0; i < 7; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              labels[i],
              style: TextStyle(
                color: timesFlag || daysList.contains((i + 1).toString())
                    ? color
                    : color.withAlpha(60),
                fontWeight: timesFlag || daysList.contains((i + 1).toString())
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
