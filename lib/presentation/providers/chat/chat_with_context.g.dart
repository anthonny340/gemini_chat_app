// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_with_context.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatWithContext)
const chatWithContextProvider = ChatWithContextProvider._();

final class ChatWithContextProvider
    extends $NotifierProvider<ChatWithContext, List<Message>> {
  const ChatWithContextProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'chatWithContextProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$chatWithContextHash();

  @$internal
  @override
  ChatWithContext create() => ChatWithContext();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Message> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Message>>(value),
    );
  }
}

String _$chatWithContextHash() => r'9374c881a7169a6d1a675939b6c580b419d23a05';

abstract class _$ChatWithContext extends $Notifier<List<Message>> {
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
