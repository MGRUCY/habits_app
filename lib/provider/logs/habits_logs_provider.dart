import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import 'package:habits_app/db/db.dart';
import 'package:habits_app/provider/db/db_provider.dart';

part 'habits_logs_provider.g.dart';

@riverpod
class HabitLogs extends _$HabitLogs {
  @override
  Future<List<Map<String, dynamic>>> build(int habitId) async {
    final db = ref.watch(appDbProvider);
    final rows = await (db.select(
      db.habitLogs,
    )..where((log) => log.habitId.equals(habitId))).get();
    return rows.map((row) => row.toJson()).toList();
  }

  Future<void> markDone(String date) async {
    final db = ref.read(appDbProvider);
    await db
        .into(db.habitLogs)
        .insert(
          HabitLogsCompanion(
            habitId: drift.Value(habitId),
            date: drift.Value(date),
            status: const drift.Value('done'),
          ),
          onConflict: DoUpdate(
            (old) => HabitLogsCompanion.custom(status: const Constant('done')),
            // target: [db.habitLogs.habitId, db.habitLogs.date],
          ),
        );
    ref.invalidateSelf();
    await future;
  }

  Future<void> markGrace(String date) async {
    final db = ref.read(appDbProvider);
    await db
        .into(db.habitLogs)
        .insert(
          HabitLogsCompanion(
            habitId: drift.Value(habitId),
            date: drift.Value(date),
            status: const drift.Value('grace'),
          ),
          onConflict: DoUpdate(
            (old) => HabitLogsCompanion.custom(status: const Constant('grace')),
            // target: [db.habitLogs.habitId, db.habitLogs.date],
          ),
        );
    ref.invalidateSelf();
    await future;
  }

  int calculateStreak(List<Map<String, dynamic>> logs) {
    final byDate = {for (final log in logs) log['date'] as String: log};
    int streak = 0;
    bool checkingToday = true;

    for (int i = 0; i < 30; i++) {
      final day = DateTime.now().subtract(Duration(days: i));
      final key =
          "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
      final log = byDate[key];

      if (log == null) {
        if (checkingToday) {
          checkingToday = false;
          continue;
        }
        break;
      }

      streak++;
      checkingToday = false;
    }

    return streak;
  }

  Future<void> unmark(String date) async {
    final db = ref.read(appDbProvider);
    await (db.delete(db.habitLogs)
          ..where((log) => log.habitId.equals(habitId) & log.date.equals(date)))
        .go();
    ref.invalidateSelf();
    await future;
  }

  String? statusForDate(List<Map<String, dynamic>> logs, String date) {
    final match = logs.where((log) => log['date'] == date);
    if (match.isEmpty) return null;
    return match.first['status'] as String?;
  }

  List<String?> last30DaysStatus(List<Map<String, dynamic>> logs) {
    final byDate = {for (final log in logs) log['date'] as String: log};
    final List<String?> result = [];

    for (int i = 29; i >= 0; i--) {
      final day = DateTime.now().subtract(Duration(days: i));
      final key =
          "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
      result.add(byDate[key]?['status'] as String?);
    }

    return result;
  }
  
  Future deleteLogs(int id) async {
    final db = ref.read(appDbProvider);
    await (db.delete(db.habitLogs)..where((l) => l.habitId.equals((id)))).go();
  }
}
