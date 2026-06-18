// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDb)
const appDbProvider = AppDbProvider._();

final class AppDbProvider extends $FunctionalProvider<AppDb, AppDb, AppDb>
    with $Provider<AppDb> {
  const AppDbProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDbProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDbHash();

  @$internal
  @override
  $ProviderElement<AppDb> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDb create(Ref ref) {
    return appDb(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDb value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDb>(value),
    );
  }
}

String _$appDbHash() => r'32b0638d6779bb0f89a8c73d6f0556d982d61268';
