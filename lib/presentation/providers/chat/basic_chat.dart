import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_chat_app/config/gemini/gemini_impl.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
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

  void addMessage(
      {required PartialText partialText,
      required User user,
      List<XFile> images = const []}) {
    if (images.isNotEmpty) {
      _addTextMessageWithImages(partialText, user, images);
      return;
    }
    _addTextMessage(partialText, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    _createMessage(partialText.text, author);
    _geminiResponseStream(partialText.text);
  }

  void _addTextMessageWithImages(
      PartialText partialText, User author, List<XFile> images) async {
    for (XFile image in images) {
      await _createImageMessage(image, author);
    }

    _createMessage(partialText.text, author);
    _geminiResponseStream(partialText.text, images: images);
  }

  void _geminiResponse(String prompt) async {
    _setIsGeminiWritting(true);

    final responseText = await gemini.getResponse(prompt);

    _setIsGeminiWritting(false);
    _createMessage(responseText, geminiUser);
  }

  void _geminiResponseStream(String prompt,
      {List<XFile> images = const []}) async {
    _setIsGeminiWritting(true);

    bool geminiMessageCreated = false;

    gemini.getResponseStream(prompt, files: images).listen(
      (responseChunk) {
        if (responseChunk.isEmpty) return;

        final updatedMessages = [...state];

        if (!geminiMessageCreated) {
          _createMessage(responseChunk, geminiUser);
          geminiMessageCreated = true;
        } else {
          final currentMessage = updatedMessages.first as TextMessage;
          final updatedMessage = currentMessage.copyWith(
            text: currentMessage.text + responseChunk,
          );

          updatedMessages[0] = updatedMessage;
          state = updatedMessages;
        }
      },
      onDone: () {
        _setIsGeminiWritting(false);
      },
      onError: (error) {
        _setIsGeminiWritting(false);
      },
    );
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

  Future<void> _createImageMessage(XFile image, User author) async {
    final message = ImageMessage(
      id: uuid.v4(),
      author: author,
      uri: image.path,
      name: image.name,
      size: await image.length(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
