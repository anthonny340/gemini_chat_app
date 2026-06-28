// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneratedHistory)
const generatedHistoryProvider = GeneratedHistoryProvider._();

final class GeneratedHistoryProvider
    extends $NotifierProvider<GeneratedHistory, List<String>> {
  const GeneratedHistoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'generatedHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$generatedHistoryHash();

  @$internal
  @override
  GeneratedHistory create() => GeneratedHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$generatedHistoryHash() => r'9379de14cbcbc2c3bf3d423b370dbd7d14445134';

abstract class _$GeneratedHistory extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<String>, List<String>>,
        List<String>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
