// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_generator_image_with_context.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatGeneratorImageWithContext)
const chatGeneratorImageWithContextProvider =
    ChatGeneratorImageWithContextProvider._();

final class ChatGeneratorImageWithContextProvider
    extends $NotifierProvider<ChatGeneratorImageWithContext, List<Message>> {
  const ChatGeneratorImageWithContextProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'chatGeneratorImageWithContextProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$chatGeneratorImageWithContextHash();

  @$internal
  @override
  ChatGeneratorImageWithContext create() => ChatGeneratorImageWithContext();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Message> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Message>>(value),
    );
  }
}

String _$chatGeneratorImageWithContextHash() =>
    r'549607b3408336d87b076c14008eaf4eaabb8afb';

abstract class _$ChatGeneratorImageWithContext
    extends $Notifier<List<Message>> {
  List<Message> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Message>, List<Message>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Message>, List<Message>>,
        List<Message>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
