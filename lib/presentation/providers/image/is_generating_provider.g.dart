// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_generating_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsGenerating)
const isGeneratingProvider = IsGeneratingProvider._();

final class IsGeneratingProvider
    extends $NotifierProvider<IsGenerating, dynamic> {
  const IsGeneratingProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isGeneratingProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isGeneratingHash();

  @$internal
  @override
  IsGenerating create() => IsGenerating();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$isGeneratingHash() => r'8ba614de3c0fd51a56ec3dc9963d8cd3f7c8ae94';

abstract class _$IsGenerating extends $Notifier<dynamic> {
  dynamic build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<dynamic, dynamic>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<dynamic, dynamic>, dynamic, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
