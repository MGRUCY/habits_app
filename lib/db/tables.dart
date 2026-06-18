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