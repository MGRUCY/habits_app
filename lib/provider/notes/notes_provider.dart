import 'package:habits_app/db/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:habits_app/provider/db/db_provider.dart';

part 'notes_provider.g.dart';

@riverpod
class NotesP extends _$NotesP {
  @override
  Future<List<Map<String, dynamic>>> build(int habitId) async {
    final db = ref.watch(appDbProvider);
    final rows = await (db.select(
      db.notes,
    )..where((n) => n.habitId.equals(habitId))).get();
    return rows.map((n) => n.toJson()).toList();
  }

  Future<void> addNote(NotesCompanion note) async {
    final db = ref.read(appDbProvider);
    await db.into(db.notes).insert(note);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteNote(String note) async {
    final db = ref.read(appDbProvider);
    await (db.delete(
      db.notes,
    )..where((n) => n.noteMsg.equals(note))).go();
    ref.invalidateSelf();
    await future;
  }
}
