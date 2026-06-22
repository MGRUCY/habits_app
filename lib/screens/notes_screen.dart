import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habits_app/db/db.dart';
import 'package:habits_app/provider/notes/notes_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen(this.habit, {super.key});
  final Map<String, dynamic> habit;

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  final TextEditingController noteController = TextEditingController();

  Future<void> submitNote(int habitId) async {
    final text = noteController.text;
    if (text.isEmpty) return;

    final newNote = NotesCompanion(
      noteMsg: drift.Value(text),
      habitId: drift.Value(habitId),
      dateAndTimeNoted: drift.Value(DateTime.now()),
    );

    await ref.read(notesPProvider(habitId).notifier).addNote(newNote);

    noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final habitId = widget.habit["id"];
    final notesAsync = ref.watch(notesPProvider(habitId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Notes",
              style: GoogleFonts.patrickHand(fontWeight: FontWeight.w300),
            ),
            Text(
              widget.habit["name"].toString(),
              style: GoogleFonts.patrickHand(
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
      body: notesAsync.when(
        data: (notes) {
          return Column(
            children: [
              Expanded(
                child: notes.isEmpty
                    ? const Center(
                        child: Text("Add notes to make things cool!"),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          DateTime dateTime =
                              DateTime.fromMillisecondsSinceEpoch(
                                int.parse(note["dateAndTimeNoted"].toString()),
                              );
                          String date = DateFormat.yMEd().format(dateTime);
                          final msg = note["noteMsg"].toString();

                          return Dismissible(
                            onDismissed: (direction) async {
                              await ref
                                  .read(notesPProvider(habitId).notifier)
                                  .deleteNote(note["noteMsg"]);
                            },
                            key: ValueKey(note["noteMsg"].toString()),
                            child: Card(
                              margin: const EdgeInsets.only(
                                top: 8,
                                right: 8,
                                left: 8,
                              ),
                              elevation: 0,
                              color: Theme.of(
                                context,
                              ).primaryColor.withAlpha(30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      date,
                                      style: GoogleFonts.patrickHand(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      msg,
                                      style: GoogleFonts.patrickHand(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: noteController,
                        decoration: InputDecoration(
                          hintText: "Type here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(
                            255,
                            216,
                            216,
                            216,
                          ).withAlpha(25),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => submitNote(habitId),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => submitNote(habitId),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
