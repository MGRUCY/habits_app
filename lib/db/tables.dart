import 'package:drift/drift.dart';

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get note => text()();
  BoolColumn get timesFlag => boolean()();
  IntColumn get timesPerWeekInt => integer()();
  TextColumn get daysList => text()();
  IntColumn get colorInt => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

}
