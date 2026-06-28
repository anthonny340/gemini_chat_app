import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_chat_app/presentation/providers/chat/chat_generator_image_with_context.dart';
import 'package:gemini_chat_app/presentation/providers/chat/chat_with_context.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';
import 'package:gemini_chat_app/presentation/widgets/chat/custom_bottom_input.dart';

class ChatGenerateImageContextScreen extends ConsumerWidget {
  const ChatGenerateImageContextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customUser = ref.watch(customUserProvider);
    final geminiUser = ref.watch(geminiUserProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatWithContext = ref.watch(chatGeneratorImageWithContextProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat Image Generator"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  ref
                      .read(chatGeneratorImageWithContextProvider.notifier)
                      .newChat();
                },
                icon: const Icon(Icons.clear_outlined))
          ],
        ),
        body: Chat(
          messages: chatWithContext,
          onSendPressed: (types.PartialText partialText) {},
          user: customUser,
          showUserAvatars: true,
          showUserNames: true,
          theme: const DarkChatTheme(),
          customBottomWidget: CustomBottomInput(
            onSend: (partialText, {images = const []}) {
              final chatWithImageContextNotifier =
                  ref.read(chatGeneratorImageWithContextProvider.notifier);
              chatWithImageContextNotifier.addMessage(
                  partialText: partialText, user: customUser, images: images);
            },
          ),
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
