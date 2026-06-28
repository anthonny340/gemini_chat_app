import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_chat_app/config/gemini/gemini_impl.dart';
import 'package:gemini_chat_app/presentation/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_generator_image_with_context.g.dart';

const uuid = Uuid();

@Riverpod(keepAlive: true)
class ChatGeneratorImageWithContext extends _$ChatGeneratorImageWithContext {
  final gemini = GeminiImpl();
  late User geminiUser;
  late User chatUser;
  late String chatId;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    chatUser = ref.read(customUserProvider);
    chatId = uuid.v4();
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
    PartialText partialText,
    User author,
    List<XFile> images,
  ) async {
    for (XFile image in images) {
      await _createImageXFileMessage(image, author);
    }

    _createMessage(partialText.text, author);
    _geminiResponseStream(partialText.text, images: images);
  }

  void _geminiResponseStream(String prompt,
      {List<XFile> images = const []}) async {
    _setIsGeminiWritting(true);

    bool geminiMessageCreated = false;

    gemini
        .getGenerateImageChatStream(
      prompt,
      chatId,
      files: images,
    )
        .listen(
      (responseChunk) async {
        // if (responseChunk.isEmpty) return;

        final type = responseChunk['type'] as String?;
        final chunk = responseChunk['chunk'] as String?;
        final done = responseChunk['done'] == true;

        if (done || type == 'end') {
          _setIsGeminiWritting(false);
          return;
        }

        final updatedMessages = [...state];

        switch (type) {
          case 'text':
            if (!geminiMessageCreated) {
              _createMessage(chunk!,
                  geminiUser); //TODO: Controlar posible error de chunk null
              geminiMessageCreated = true;
            } else {
              final currentMessage = updatedMessages.first as TextMessage;
              final updatedMessage = currentMessage.copyWith(
                text: currentMessage.text + chunk!,
              );

              updatedMessages[0] = updatedMessage;
              state = updatedMessages;
            }
            break;
          case 'image':
            print(chunk);
            await _createImageUrlMessage(chunk!,
                geminiUser); //TODO: Controlar posible error de chunk null

            break;
          case 'error':
            _createMessage(chunk!, geminiUser);
            break;
          // case 'end':
          //   break;
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
  void newChat() {
    chatId = uuid.v4();
    state = [];
  }

  void loadPreviusMessage(String chatId) {
    // TODO Implementar la carga de los mensajes segun el chatId
  }

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

  Future<void> _createImageXFileMessage(XFile image, User author) async {
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

  Future<void> _createImageUrlMessage(String image, User author) async {
    image = image.replaceFirst('http://127.0.0.1:8000',
        'https://overrude-socioeconomic-herlinda.ngrok-free.dev');

    final message = ImageMessage(
      id: uuid.v4(),
      author: author,
      uri: image,
      name: image.split('/').last,
      size: 0,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
