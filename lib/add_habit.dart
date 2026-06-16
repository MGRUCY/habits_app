import 'package:flutter/material.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("HABITS")),
      body: Center(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(),
              TextFormField(),
              Text("schedule"),
              Row(
                children: [
                  TextButton(onPressed: () {}, child: Text("Week days")),
                  TextButton(onPressed: () {}, child: Text("Times a week")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("S", style: TextStyle(fontSize: 6)),
                  ),
                  TextButton(onPressed: () {}, child: Text("M")),
                  TextButton(onPressed: () {}, child: Text("T")),
                  TextButton(onPressed: () {}, child: Text("W")),
                  TextButton(onPressed: () {}, child: Text("T")),
                  TextButton(onPressed: () {}, child: Text("F")),
                  TextButton(onPressed: () {}, child: Text("S")),
                ],
              ),
              Text("Habit Color"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.blue),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.red),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.brown),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.yellow),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.purple),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.green),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Container(color: Colors.cyan),
                  ),
                ],
              ),
              TextButton(onPressed: () {}, child: Text("Create Habit")),
            ],
          ),
        ),
      ),
    );
  }
}
