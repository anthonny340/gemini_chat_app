import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'basic_chat.g.dart';

const uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<Message> build() {
    return [];
  }

  void addMessage({required PartialText partialText, required User user}) {
    //TODO Evaluar si es una imagen
    _addTextMessage(partialText, user);

    _geminiResponse(partialText.text);
  }

  void _addTextMessage(PartialText partialText, User author) {
    final message = TextMessage(
      id: uuid.v4(),
      author: author,
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }

  void _geminiResponse(String prompt) async {
    final geminiWriting = ref.read(isGeminiWritingProvider.notifier);
    final gemini = ref.read(geminiUserProvider);
    geminiWriting.setIsWriting();

    await Future.delayed(const Duration(seconds: 3));
    geminiWriting.setIsNotWriting();

    final geminiMessage = TextMessage(
      id: uuid.v4(),
      author: gemini,
      text: "Gemini responde a la siguiente prompt: $prompt",
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [geminiMessage, ...state];
  }
}
