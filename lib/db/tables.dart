import 'package:drift/drift.dart';
import 'dart:convert';

class DaysListConverter extends TypeConverter<List<String>, String> {
  const DaysListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return (jsonDecode(fromDb) as List).cast<String>();
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get note => text()();
  BoolColumn get timesFlag => boolean()();
  IntColumn get timesPerWeekInt => integer()();
  TextColumn get daysList => text().map(const DaysListConverter())();
  IntColumn get colorInt => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class HabitLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  TextColumn get date => text()();
  TextColumn get status => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {habitId, date},
  ];
}

class Notes extends Table {
  TextColumn get noteMsg => text()();
  IntColumn get habitId => integer().references(Habits, #id)();
  DateTimeColumn get dateAndTimeNoted =>
      dateTime().withDefault(currentDateAndTime)();
}
