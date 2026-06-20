// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_logs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitLogs)
const habitLogsProvider = HabitLogsFamily._();

final class HabitLogsProvider
    extends $AsyncNotifierProvider<HabitLogs, List<Map<String, dynamic>>> {
  const HabitLogsProvider._({
    required HabitLogsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'habitLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$habitLogsHash();

  @override
  String toString() {
    return r'habitLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HabitLogs create() => HabitLogs();

  @override
  bool operator ==(Object other) {
    return other is HabitLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$habitLogsHash() => r'a651282fa449bd80db2e56f695b061982b96c131';

final class HabitLogsFamily extends $Family
    with
        $ClassFamilyOverride<
          HabitLogs,
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>,
          int
        > {
  const HabitLogsFamily._()
    : super(
        retry: null,
        name: r'habitLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HabitLogsProvider call(int habitId) =>
      HabitLogsProvider._(argument: habitId, from: this);

  @override
  String toString() => r'habitLogsProvider';
}

abstract class _$HabitLogs extends $AsyncNotifier<List<Map<String, dynamic>>> {
  late final _$args = ref.$arg as int;
  int get habitId => _$args;

  FutureOr<List<Map<String, dynamic>>> build(int habitId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<Map<String, dynamic>>>,
              List<Map<String, dynamic>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Map<String, dynamic>>>,
                List<Map<String, dynamic>>
              >,
              AsyncValue<List<Map<String, dynamic>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
