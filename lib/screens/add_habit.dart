import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  StepperController stepperController = StepperController();
  List<String> daysCont = [];
  int colorCont = 0;

  bool timesFlag = false;
  int initialLabelIndex = 0;
  int initialColorIndex = 0;

  final List<DayInWeek> days = [
    DayInWeek("Mon", dayKey: "1"),
    DayInWeek("Tue", dayKey: "2"),
    DayInWeek("Wed", dayKey: "3"),
    DayInWeek("Thu", dayKey: "4"),
    DayInWeek("Fri", dayKey: "5"),
    DayInWeek("Sat", dayKey: "6"),
    DayInWeek("Sun", dayKey: "7"),
  ];

  final listColors = habitColors
      .map(
        (color) => Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      )
      .toList();

  edit() {
    if (widget.editHabit != null) {
      nameController.text = widget.editHabit!["name"];
      noteController.text = widget.editHabit!["note"];
      timesFlag = widget.editHabit!["timesFlag"];
      stepperController.currentValue = widget.editHabit!["timesPerWeekInt"];
      daysCont = widget.editHabit!["daysList"]
          .toString()
          .replaceAll("]", "")
          .replaceAll("[", "")
          .split(',');
      colorCont = widget.editHabit!["colorInt"];
    }
  }

  @override
  Widget build(BuildContext context) {
    edit();
    debugPrint("editHabit it is: ${widget.editHabit.toString()}");
    if (widget.editHabit != null) {
      nameController.text = widget.editHabit!["name"];
      noteController.text = widget.editHabit!["note"];
      timesFlag = widget.editHabit!["timesFlag"];
      stepperController.currentValue = widget.editHabit!["timesPerWeekInt"];
      daysCont = widget.editHabit!["daysList"]
          .toString()
          .replaceAll("]", "")
          .replaceAll("[", "")
          .split(',');
      colorCont = widget.editHabit!["colorInt"];
    }

    final habit = ref.watch(habitsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (widget.editHabit == null)
            ? Text("New Habit")
            : Text("Edit Habit"),
        actions: [
          //submit
          IconButton(
            iconSize: 34,
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a habit name")),
                );
                return;
              }

              final habitsCompanion = HabitsCompanion(
                name: drift.Value(nameController.text.trim()),
                note: drift.Value(noteController.text.trim()),
                timesFlag: drift.Value(timesFlag),
                timesPerWeekInt: drift.Value(stepperController.currentValue),
                daysList: drift.Value(daysCont),
                colorInt: drift.Value(colorCont),
                createdAt: drift.Value(DateTime.now()),
              );

              await habit.addHabit(habitsCompanion);

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //input 1
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hint: Text("Title", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),

            //input 2
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: TextField(
                controller: noteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hint: Text("Note", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),

            //input 3
            SizedBox(height: 14),
            Text("schedule", style: TextStyle(color: Colors.grey)),

            SizedBox(height: 10),

            ToggleSwitch(
              minWidth: 200,
              cornerRadius: 20.0,
              activeFgColor: const Color.fromARGB(255, 255, 255, 255),
              inactiveBgColor: const Color.fromARGB(26, 243, 243, 243),
              inactiveFgColor: const Color.fromARGB(255, 255, 255, 255),
              initialLabelIndex: initialLabelIndex,
              totalSwitches: 2,
              labels: ['Specific days', 'Times per week'],
              radiusStyle: false,
              onToggle: (index) {
                setState(() {
                  initialLabelIndex = index!;
                  if (index == 1) {
                    timesFlag = true;
                  } else {
                    timesFlag = false;
                  }
                });
                print(timesFlag);
              },
            ),
            SizedBox(height: 20),
            timesFlag
                ? Row(
                    mainAxisAlignment: .center,
                    children: [
                      //input 4
                      Text("How many times per week?"),
                      SizedBox(width: 20),
                      CountStepper(
                        iconColor: Colors.white,
                        defaultValue: 7,
                        max: 7,
                        min: 1,
                        iconDecrementColor: Colors.white,
                        splashRadius: 100,
                        space: 2,
                        controller: stepperController,
                      ),
                    ],
                  )
                :
                  //input 5
                  SelectWeekDays(
                    fontSize: 10,
                    days: days,
                    border: true,
                    padding: 1,
                    borderWidth: 0.2,
                    width: MediaQuery.of(context).size.width / 1.1,
                    boxDecoration: BoxDecoration(
                      color: const Color.fromARGB(0, 48, 48, 48),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onSelect: (values) {
                      daysCont = values;
                      print("days values: ${daysCont}");
                    },
                  ),

            SizedBox(height: 12),
            Text("color", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 6),

            //input 6
            ToggleSwitch(
              minWidth: 200,
              cornerRadius: 40,
              minHeight: 44,
              borderWidth: 0,
              borderColor: [Color.fromARGB(26, 243, 243, 243)],
              activeBgColor: [Color.fromARGB(26, 243, 243, 243)],
              inactiveBgColor: const Color.fromARGB(0, 243, 243, 243),
              inactiveFgColor: const Color.fromARGB(255, 255, 255, 255),
              initialLabelIndex: initialColorIndex,
              totalSwitches: 7,
              doubleTapDisable: true,
              dividerMargin: 30,
              customWidgets: listColors,
              labels: ["", "", "", "", "", "", ""],
              radiusStyle: true,
              onToggle: (index) {
                if (index != null) colorCont = index;
                print(colorCont);
              },
            ),
          ],
        ),
      ),
    );
  }
}
