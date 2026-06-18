// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timesFlagMeta = const VerificationMeta(
    'timesFlag',
  );
  @override
  late final GeneratedColumn<bool> timesFlag = GeneratedColumn<bool>(
    'times_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("times_flag" IN (0, 1))',
    ),
  );
  static const VerificationMeta _timesPerWeekIntMeta = const VerificationMeta(
    'timesPerWeekInt',
  );
  @override
  late final GeneratedColumn<int> timesPerWeekInt = GeneratedColumn<int>(
    'times_per_week_int',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> daysList =
      GeneratedColumn<String>(
        'days_list',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($HabitsTable.$converterdaysList);
  static const VerificationMeta _colorIntMeta = const VerificationMeta(
    'colorInt',
  );
  @override
  late final GeneratedColumn<int> colorInt = GeneratedColumn<int>(
    'color_int',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    note,
    timesFlag,
    timesPerWeekInt,
    daysList,
    colorInt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('times_flag')) {
      context.handle(
        _timesFlagMeta,
        timesFlag.isAcceptableOrUnknown(data['times_flag']!, _timesFlagMeta),
      );
    } else if (isInserting) {
      context.missing(_timesFlagMeta);
    }
    if (data.containsKey('times_per_week_int')) {
      context.handle(
        _timesPerWeekIntMeta,
        timesPerWeekInt.isAcceptableOrUnknown(
          data['times_per_week_int']!,
          _timesPerWeekIntMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timesPerWeekIntMeta);
    }
    if (data.containsKey('color_int')) {
      context.handle(
        _colorIntMeta,
        colorInt.isAcceptableOrUnknown(data['color_int']!, _colorIntMeta),
      );
    } else if (isInserting) {
      context.missing(_colorIntMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      timesFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}times_flag'],
      )!,
      timesPerWeekInt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_per_week_int'],
      )!,
      daysList: $HabitsTable.$converterdaysList.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}days_list'],
        )!,
      ),
      colorInt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_int'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdaysList =
      const DaysListConverter();
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String note;
  final bool timesFlag;
  final int timesPerWeekInt;
  final List<String> daysList;
  final int colorInt;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.name,
    required this.note,
    required this.timesFlag,
    required this.timesPerWeekInt,
    required this.daysList,
    required this.colorInt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['note'] = Variable<String>(note);
    map['times_flag'] = Variable<bool>(timesFlag);
    map['times_per_week_int'] = Variable<int>(timesPerWeekInt);
    {
      map['days_list'] = Variable<String>(
        $HabitsTable.$converterdaysList.toSql(daysList),
      );
    }
    map['color_int'] = Variable<int>(colorInt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      note: Value(note),
      timesFlag: Value(timesFlag),
      timesPerWeekInt: Value(timesPerWeekInt),
      daysList: Value(daysList),
      colorInt: Value(colorInt),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      note: serializer.fromJson<String>(json['note']),
      timesFlag: serializer.fromJson<bool>(json['timesFlag']),
      timesPerWeekInt: serializer.fromJson<int>(json['timesPerWeekInt']),
      daysList: serializer.fromJson<List<String>>(json['daysList']),
      colorInt: serializer.fromJson<int>(json['colorInt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'note': serializer.toJson<String>(note),
      'timesFlag': serializer.toJson<bool>(timesFlag),
      'timesPerWeekInt': serializer.toJson<int>(timesPerWeekInt),
      'daysList': serializer.toJson<List<String>>(daysList),
      'colorInt': serializer.toJson<int>(colorInt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    int? id,
    String? name,
    String? note,
    bool? timesFlag,
    int? timesPerWeekInt,
    List<String>? daysList,
    int? colorInt,
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    note: note ?? this.note,
    timesFlag: timesFlag ?? this.timesFlag,
    timesPerWeekInt: timesPerWeekInt ?? this.timesPerWeekInt,
    daysList: daysList ?? this.daysList,
    colorInt: colorInt ?? this.colorInt,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      note: data.note.present ? data.note.value : this.note,
      timesFlag: data.timesFlag.present ? data.timesFlag.value : this.timesFlag,
      timesPerWeekInt: data.timesPerWeekInt.present
          ? data.timesPerWeekInt.value
          : this.timesPerWeekInt,
      daysList: data.daysList.present ? data.daysList.value : this.daysList,
      colorInt: data.colorInt.present ? data.colorInt.value : this.colorInt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('timesFlag: $timesFlag, ')
          ..write('timesPerWeekInt: $timesPerWeekInt, ')
          ..write('daysList: $daysList, ')
          ..write('colorInt: $colorInt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    note,
    timesFlag,
    timesPerWeekInt,
    daysList,
    colorInt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.note == this.note &&
          other.timesFlag == this.timesFlag &&
          other.timesPerWeekInt == this.timesPerWeekInt &&
          other.daysList == this.daysList &&
          other.colorInt == this.colorInt &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> note;
  final Value<bool> timesFlag;
  final Value<int> timesPerWeekInt;
  final Value<List<String>> daysList;
  final Value<int> colorInt;
  final Value<DateTime> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.note = const Value.absent(),
    this.timesFlag = const Value.absent(),
    this.timesPerWeekInt = const Value.absent(),
    this.daysList = const Value.absent(),
    this.colorInt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String note,
    required bool timesFlag,
    required int timesPerWeekInt,
    required List<String> daysList,
    required int colorInt,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       note = Value(note),
       timesFlag = Value(timesFlag),
       timesPerWeekInt = Value(timesPerWeekInt),
       daysList = Value(daysList),
       colorInt = Value(colorInt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? note,
    Expression<bool>? timesFlag,
    Expression<int>? timesPerWeekInt,
    Expression<String>? daysList,
    Expression<int>? colorInt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (note != null) 'note': note,
      if (timesFlag != null) 'times_flag': timesFlag,
      if (timesPerWeekInt != null) 'times_per_week_int': timesPerWeekInt,
      if (daysList != null) 'days_list': daysList,
      if (colorInt != null) 'color_int': colorInt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? note,
    Value<bool>? timesFlag,
    Value<int>? timesPerWeekInt,
    Value<List<String>>? daysList,
    Value<int>? colorInt,
    Value<DateTime>? createdAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      timesFlag: timesFlag ?? this.timesFlag,
      timesPerWeekInt: timesPerWeekInt ?? this.timesPerWeekInt,
      daysList: daysList ?? this.daysList,
      colorInt: colorInt ?? this.colorInt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (timesFlag.present) {
      map['times_flag'] = Variable<bool>(timesFlag.value);
    }
    if (timesPerWeekInt.present) {
      map['times_per_week_int'] = Variable<int>(timesPerWeekInt.value);
    }
    if (daysList.present) {
      map['days_list'] = Variable<String>(
        $HabitsTable.$converterdaysList.toSql(daysList.value),
      );
    }
    if (colorInt.present) {
      map['color_int'] = Variable<int>(colorInt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('note: $note, ')
          ..write('timesFlag: $timesFlag, ')
          ..write('timesPerWeekInt: $timesPerWeekInt, ')
          ..write('daysList: $daysList, ')
          ..write('colorInt: $colorInt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habits];
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String name,
      required String note,
      required bool timesFlag,
      required int timesPerWeekInt,
      required List<String> daysList,
      required int colorInt,
      Value<DateTime> createdAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> note,
      Value<bool> timesFlag,
      Value<int> timesPerWeekInt,
      Value<List<String>> daysList,
      Value<int> colorInt,
      Value<DateTime> createdAt,
    });

class $$HabitsTableFilterComposer extends Composer<_$AppDb, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get timesFlag => $composableBuilder(
    column: $table.timesFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesPerWeekInt => $composableBuilder(
    column: $table.timesPerWeekInt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get daysList => $composableBuilder(
    column: $table.daysList,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get colorInt => $composableBuilder(
    column: $table.colorInt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer extends Composer<_$AppDb, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get timesFlag => $composableBuilder(
    column: $table.timesFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesPerWeekInt => $composableBuilder(
    column: $table.timesPerWeekInt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get daysList => $composableBuilder(
    column: $table.daysList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorInt => $composableBuilder(
    column: $table.colorInt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer extends Composer<_$AppDb, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get timesFlag =>
      $composableBuilder(column: $table.timesFlag, builder: (column) => column);

  GeneratedColumn<int> get timesPerWeekInt => $composableBuilder(
    column: $table.timesPerWeekInt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get daysList =>
      $composableBuilder(column: $table.daysList, builder: (column) => column);

  GeneratedColumn<int> get colorInt =>
      $composableBuilder(column: $table.colorInt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, BaseReferences<_$AppDb, $HabitsTable, Habit>),
          Habit,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDb db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> timesFlag = const Value.absent(),
                Value<int> timesPerWeekInt = const Value.absent(),
                Value<List<String>> daysList = const Value.absent(),
                Value<int> colorInt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                note: note,
                timesFlag: timesFlag,
                timesPerWeekInt: timesPerWeekInt,
                daysList: daysList,
                colorInt: colorInt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String note,
                required bool timesFlag,
                required int timesPerWeekInt,
                required List<String> daysList,
                required int colorInt,
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                note: note,
                timesFlag: timesFlag,
                timesPerWeekInt: timesPerWeekInt,
                daysList: daysList,
                colorInt: colorInt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, BaseReferences<_$AppDb, $HabitsTable, Habit>),
      Habit,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
}
