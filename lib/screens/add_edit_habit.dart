import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habits_app/db/db.dart';
import 'package:habits_app/settings/habit_colors.dart';
import 'package:habits_app/provider/habits/habits_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:day_picker/day_picker.dart';
import 'package:count_stepper/count_stepper.dart';

class AddEditHabit extends ConsumerStatefulWidget {
  const AddEditHabit(this.editHabit, {super.key});
  final Map<String, dynamic>? editHabit;

  @override
  ConsumerState<AddEditHabit> createState() => _AddEditHabitState();
}

class _AddEditHabitState extends ConsumerState<AddEditHabit> {
  late TextEditingController nameController;
  late TextEditingController noteController;
  late StepperController stepperController;

  List<String> daysCont = [];
  int colorCont = 0;
  bool timesFlag = false;
  int initialLabelIndex = 0;

  final List<DayInWeek> daysListSource = [
    DayInWeek("Mon", dayKey: "1"),
    DayInWeek("Tue", dayKey: "2"),
    DayInWeek("Wed", dayKey: "3"),
    DayInWeek("Thu", dayKey: "4"),
    DayInWeek("Fri", dayKey: "5"),
    DayInWeek("Sat", dayKey: "6"),
    DayInWeek("Sun", dayKey: "7"),
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.editHabit?["name"] ?? "",
    );
    noteController = TextEditingController(
      text: widget.editHabit?["note"] ?? "",
    );
    stepperController = StepperController();
    stepperController.currentValue = widget.editHabit?["timesPerWeekInt"] ?? 7;

    if (widget.editHabit != null) {
      timesFlag = widget.editHabit!["timesFlag"] ?? false;
      initialLabelIndex = timesFlag ? 1 : 0;
      colorCont = widget.editHabit!["colorInt"] ?? 0;

      var rawDays = widget.editHabit!["daysList"];
      if (rawDays is List) {
        daysCont = rawDays.cast<String>();
      } else {
        daysCont = rawDays
            .toString()
            .replaceAll("]", "")
            .replaceAll("[", "")
            .split(',')
            .map((e) => e.trim())
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habit = ref.watch(habitsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.editHabit == null ? "New Habit" : "Edit Habit",
          style: GoogleFonts.patrickHand(),
        ),
        actions: [
          IconButton(
            iconSize: 34,
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please enter a habit name",
                      style: GoogleFonts.patrickHand(),
                    ),
                  ),
                );
                return;
              }

              final habitsCompanion = HabitsCompanion(
                id: widget.editHabit != null
                    ? drift.Value(widget.editHabit!['id'])
                    : const drift.Value.absent(),
                name: drift.Value(nameController.text.trim()),
                note: drift.Value(noteController.text.trim()),
                timesFlag: drift.Value(timesFlag),
                timesPerWeekInt: drift.Value(stepperController.currentValue),
                daysList: drift.Value(daysCont),
                colorInt: drift.Value(colorCont),
                createdAt: drift.Value(
                  widget.editHabit != null
                      ? DateTime.fromMillisecondsSinceEpoch(
                          int.parse(widget.editHabit!['createdAt'].toString()),
                        )
                      : DateTime.now(),
                ),
              );

              if (widget.editHabit == null) {
                await habit.addHabit(habitsCompanion);
              } else {
                await habit.updateHabit(habitsCompanion);
              }
              if (widget.editHabit != null) {
                if (context.mounted) Navigator.pop(context);
              }
              if (context.mounted) Navigator.pop(context);
            },
            icon: Icon(
              widget.editHabit == null ? Icons.add : Icons.done_all_rounded,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Title",
                  hintStyle: GoogleFonts.patrickHand(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Note",
                  hintStyle: GoogleFonts.patrickHand(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 14),
            Text(
              "schedule",
              style: GoogleFonts.patrickHand(color: Colors.grey),
            ),
            SizedBox(height: 10),
            ToggleSwitch(
              minWidth: 200,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: theme.colorScheme.surfaceContainerHighest
                  .withAlpha(100),
              inactiveFgColor: Colors.white,
              activeBgColor: [theme.colorScheme.primary],
              initialLabelIndex: initialLabelIndex,
              totalSwitches: 2,
              labels: ['Specific days', 'Times per week'],
              onToggle: (index) {
                setState(() {
                  initialLabelIndex = index!;
                  timesFlag = (index == 1);
                });
              },
            ),
            SizedBox(height: 20),
            timesFlag
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "How many times per week?",
                        style: GoogleFonts.patrickHand(),
                      ),
                      SizedBox(width: 20),
                      CountStepper(
                        iconColor: Colors.white,
                        defaultValue: stepperController.currentValue,
                        max: 7,
                        min: 1,
                        controller: stepperController,
                      ),
                    ],
                  )
                : SelectWeekDays(
                    fontSize: 10,
                    days: daysListSource,
                    border: true,
                    padding: 1,
                    width: MediaQuery.of(context).size.width / 1.1,
                    boxDecoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onSelect: (values) => daysCont = values,
                  ),
            SizedBox(height: 20),
            Text("color", style: GoogleFonts.patrickHand(color: Colors.grey)),
            SizedBox(height: 12),
            Wrap(
              spacing: 15,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(habitColors.length, (index) {
                return GestureDetector(
                  onTap: () => setState(() => colorCont = index),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorCont == index
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: habitColors[index],
                      radius: 15,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
