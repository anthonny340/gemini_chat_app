import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_chat_app/config/gemini/gemini_impl.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'basic_chat.g.dart';

const uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  final gemini = GeminiImpl();
  late User geminiUser;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    return [];
  }

  void addMessage({required PartialText partialText, required User user}) {
    //TODO Evaluar si es una imagen
    _addTextMessage(partialText, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    _createMessage(partialText.text, author);
    _geminiResponse(partialText.text);
  }

  void _geminiResponse(String prompt) async {
    _setIsGeminiWritting(true);

    final responseText = await gemini.getResponse(prompt);

    _setIsGeminiWritting(false);
    _createMessage(responseText, geminiUser);
  }

  // Helper methods
  void _setIsGeminiWritting(bool isWritting) {
    final geminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isWritting ? geminiWriting.setIsWriting() : geminiWriting.setIsNotWriting();
  }

  void _createMessage(String text, User author) {
    final message = TextMessage(
      id: uuid.v4(),
      author: author,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
