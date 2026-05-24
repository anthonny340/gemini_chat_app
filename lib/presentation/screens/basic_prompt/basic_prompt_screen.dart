import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_chat_app/presentation/providers/users/user_provider.dart';
import 'package:uuid/uuid.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customUser = ref.watch(customUserProvider);
    final geminiUser = ref.watch(geminiUserProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("BasicPromptScreen"),
        centerTitle: true,
      ),
      body: Chat(
        messages: [
          types.TextMessage(
              author: geminiUser,
              id: const Uuid().v4(),
              text: 'Que pasa puto?'),
          types.TextMessage(
              author: customUser, id: const Uuid().v4(), text: 'Sapo'),
        ],
        onSendPressed: (types.PartialText partialText) {
          // messages.add(types.TextMessage(
          //     author: customUser,
          //     id: const Uuid().v4(),
          //     text: partialText.text));
          print(partialText.text);
        },
        user: customUser,
        showUserAvatars: true,
        showUserNames: true,
        theme: const DarkChatTheme(),
        typingIndicatorOptions: TypingIndicatorOptions(
            typingUsers: isGeminiWriting ? [geminiUser] : [],
            customTypingWidget: const Center(
              child: Text("Gemini esta pensando...",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  )),
            )),
      ),
    );
  }
}
