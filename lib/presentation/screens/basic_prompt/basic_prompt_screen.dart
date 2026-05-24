import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customUser = ref.watch(customUserProvider);
    final geminiUser = ref.watch(geminiUserProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final basicChat = ref.watch(basicChatProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BasicPromptScreen"),
          centerTitle: true,
        ),
        body: Chat(
          messages: basicChat,
          onSendPressed: (types.PartialText partialText) {
            final basicChatNotifier = ref.read(basicChatProvider.notifier);
            basicChatNotifier.addMessage(
                partialText: partialText, user: customUser);
          },
          user: customUser,
          showUserAvatars: true,
          showUserNames: true,
          theme: const DarkChatTheme(),
          typingIndicatorOptions: TypingIndicatorOptions(
            typingUsers: isGeminiWriting ? [geminiUser] : [],
            customTypingWidget: const Center(
              child: Text(
                "Gemini esta pensando...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
