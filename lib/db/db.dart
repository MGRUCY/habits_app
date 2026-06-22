import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:habits_app/db/tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Habits, HabitLogs, Notes])
class AppDb extends _$AppDb {
  static AppDb? _instance;
  factory AppDb() {
    return _instance ??= AppDb.internal();
  }
  AppDb.internal() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async{
      if (from == 1) {
        await m.createTable(notes);
      }
    },
  );
}
