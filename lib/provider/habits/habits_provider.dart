import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:habits_app/db/db.dart';
import 'package:habits_app/provider/db/db_provider.dart';

part 'habits_provider.g.dart';

@riverpod
class Habits extends _$Habits {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    final db = ref.watch(appDbProvider);
    final rows = await db.select(db.habits).get();
    return rows.map((h) => h.toJson()).toList();
  }

  Future<void> addHabit(HabitsCompanion entry) async {
    final db = ref.read(appDbProvider);
    await db.into(db.habits).insert(entry);
    ref.invalidateSelf();
    await future;
  }

}