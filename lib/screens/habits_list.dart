import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habits_app/provider/habits/habits_provider.dart';
import 'package:habits_app/provider/logs/habits_logs_provider.dart';
import 'package:habits_app/screens/add_edit_habit.dart';
import 'package:habits_app/screens/habit_details_screen.dart';
import 'package:habits_app/settings/habit_colors.dart';
import 'package:habits_app/settings/today_string.dart';

class HabitsList extends ConsumerWidget {
  const HabitsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => (AddEditHabit(null)))),
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return theme.colorScheme.primaryContainer.withAlpha(50);
          }),
        ),
        child: Text("+ NEW HABIT"),
      ),
      appBar: AppBar(title: Text("Habits", style: GoogleFonts.patrickHand())),
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
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withAlpha(25),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(50),
          width: 0.7,
        ),
      ),
      child: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) return SizedBox(width: 1);

          final allHabitStatuses = habits.map((habit) {
            final logs = ref
                .watch(habitLogsProvider(habit['id']))
                .maybeWhen(
                  data: (d) => d,
                  orElse: () => <Map<String, dynamic>>[],
                );
            return ref
                .read(habitLogsProvider(habit['id']).notifier)
                .last30DaysStatus(logs);
          }).toList();

          int globalStreak = 0;
          for (int i = 29; i >= 0; i--) {
            bool allDoneThatDay = allHabitStatuses.every((statusList) {
              final status = statusList[i];
              return status == 'done' || status == 'grace';
            });
            if (allDoneThatDay) {
              globalStreak++;
            } else {
              if (i == 29) continue;
              break;
            }
          }

          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Your Rhythm",
                        style: GoogleFonts.patrickHand(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        globalStreak > 0 ? "$globalStreak 🔥" : "0",
                        style: GoogleFonts.patrickHand(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "To Be Consistent!",
                    style: GoogleFonts.patrickHand(fontSize: 8, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Column(
                children: habits
                    .map((habit) => _HabitDotsRow(habit: habit))
                    .toList(),
              ),
            ],
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text("Error: $err"),
      ),
    );
  }
}

class _HabitDotsRow extends ConsumerWidget {
  final Map<String, dynamic> habit;
  const _HabitDotsRow({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = habitColors[habit['colorInt'] as int];
    final logsAsync = ref.watch(habitLogsProvider(habit['id']));

    return logsAsync.maybeWhen(
      data: (logs) {
        final statuses = ref
            .read(habitLogsProvider(habit['id']).notifier)
            .last30DaysStatus(logs);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: statuses.map((status) {
              Color dotColor = color.withAlpha(50);
              if (status == 'done') dotColor = color;
              if (status == 'grace') dotColor = color.withAlpha(110);
              return Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              );
            }).toList(),
          ),
        );
      },
      orElse: () => SizedBox(),
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

    final todayStatus = logsAsync.maybeWhen(
      data: (logs) => ref
          .read(habitLogsProvider(habitId).notifier)
          .statusForDate(logs, today),
      orElse: () => null,
    );

    int streak = logsAsync.maybeWhen(
      data: (logs) =>
          ref.read(habitLogsProvider(habitId).notifier).calculateStreak(logs),
      orElse: () => 0,
    );

    final List<String?> last30 = logsAsync.maybeWhen(
      data: (logs) =>
          ref.read(habitLogsProvider(habitId).notifier).last30DaysStatus(logs),
      orElse: () => List.filled(30, null),
    );

    final List<FlSpot> spots = last30.sublist(23).asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), (e.value == 'done') ? 1.0 : 0.0);
    }).toList();

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
                    final notifier = ref.read(
                      habitLogsProvider(habitId).notifier,
                    );
                    if (todayStatus == null) {
                      notifier.markDone(today);
                    } else {
                      notifier.unmark(today);
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: todayStatus == 'done'
                          ? color
                          : (todayStatus == 'grace'
                                ? color.withAlpha(100)
                                : Colors.transparent),
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Icon(
                      todayStatus == 'grace'
                          ? Icons.auto_awesome_rounded
                          : Icons.check,
                      color: todayStatus != null
                          ? Colors.white
                          : Colors.transparent,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.habit['name'] ?? '',
                    style: GoogleFonts.patrickHand(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  streak > 0 ? "$streak 🔥" : streak.toString(),
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
                SizedBox(
                  width: 70,
                  height: 30,
                  child: LineChart(
                    LineChartData(lineTouchData: LineTouchData(enabled: false),
                      
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 1,
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: false,
                          color: color,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
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
    List labels = ["M", "T", "W", "T", "F", "S", "S"];
    bool timesFlag = widget.habit['timesFlag'] ?? false;
    List daysList = (widget.habit['daysList'] as List?)?.cast() ?? [];

    return Row(
      children: [
        for (int i = 0; i < 7; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              labels[i],
              style: GoogleFonts.patrickHand(
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
