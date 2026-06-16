import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

class Habits extends Table {
  TextColumn get id => text().named("id")();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Habits])
class AppDb extends _$AppDb {
  static AppDb? _instance;
  factory AppDb() {
    return _instance ??= AppDb.internal();
  }
  AppDb.internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  
}
