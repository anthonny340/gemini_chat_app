// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_art_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedArt)
const selectedArtProvider = SelectedArtProvider._();

final class SelectedArtProvider
    extends $NotifierProvider<SelectedArt, dynamic> {
  const SelectedArtProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedArtProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedArtHash();

  @$internal
  @override
  SelectedArt create() => SelectedArt();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$selectedArtHash() => r'59509ceaa1b69af63a4a58db5dfc19de72e924af';

abstract class _$SelectedArt extends $Notifier<dynamic> {
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
