// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotesP)
const notesPProvider = NotesPFamily._();

final class NotesPProvider
    extends $AsyncNotifierProvider<NotesP, List<Map<String, dynamic>>> {
  const NotesPProvider._({
    required NotesPFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'notesPProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$notesPHash();

  @override
  String toString() {
    return r'notesPProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NotesP create() => NotesP();

  @override
  bool operator ==(Object other) {
    return other is NotesPProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$notesPHash() => r'a6e16d6faa27ddd3f0978cec7aeda537af025338';

final class NotesPFamily extends $Family
    with
        $ClassFamilyOverride<
          NotesP,
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>,
          int
        > {
  const NotesPFamily._()
    : super(
        retry: null,
        name: r'notesPProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NotesPProvider call(int habitId) =>
      NotesPProvider._(argument: habitId, from: this);

  @override
  String toString() => r'notesPProvider';
}

abstract class _$NotesP extends $AsyncNotifier<List<Map<String, dynamic>>> {
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
