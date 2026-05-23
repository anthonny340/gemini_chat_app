import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class BasicPromptScreen extends StatelessWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const user = types.User(
      id: "user-id-anthonny",
      firstName: "Anthonny",
      lastName: "Sacheri",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/12225/12225881.png",
    );
    const geminiUser = types.User(
      id: "gemini-id",
      firstName: "Gemini",
      lastName: "Flash Model",
      imageUrl:
          "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/google-gemini-icon.png",
    );

    final messages = <types.Message>[
      types.TextMessage(
          author: user, id: const Uuid().v4(), text: 'Hola mundo'),
      types.TextMessage(
          author: geminiUser, id: const Uuid().v4(), text: 'Que quieres puto'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("BasicPromptScreen"),
        centerTitle: true,
      ),
      body: Chat(
        messages: messages,
        onSendPressed: (types.PartialText partialText) {
          messages.add(types.TextMessage(
              author: user, id: const Uuid().v4(), text: partialText.text));
          print(partialText.text);
        },
        user: user,
        showUserAvatars: true,
        showUserNames: true,
        theme: const DarkChatTheme(),
        typingIndicatorOptions: const TypingIndicatorOptions(typingUsers: [
          // geminiUser TODO
        ], customTypingWidget: Text("Gemini esta pensando...")),
      ),
    );
  }
}
