import 'package:gemini_chat_app/config/gemini/gemini_impl.dart';
import 'package:gemini_chat_app/presentation/providers/image/generated_history_provider.dart';
import 'package:gemini_chat_app/presentation/providers/image/is_generating_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated_images_provider.g.dart';

@riverpod
class GeneratedImages extends _$GeneratedImages {
  final GeminiImpl gemini = GeminiImpl();
  late final IsGenerating isGeneratingNotifier;
  late final GeneratedHistory generatedHistoryNotifier;
  String previousPrompt = '';
  List<XFile> previousImages = [];
  @override
  List<String> build() {
    generatedHistoryNotifier = ref.read(generatedHistoryProvider.notifier);
    isGeneratingNotifier = ref.read(isGeneratingProvider.notifier);
    return [];
  }

  void addImages(String imageUrl) {
    generatedHistoryNotifier.addImage(imageUrl);
    state = [...state, imageUrl];
  }

  void cleanImages() {
    state = [];
  }

  Future<void> generateImages(
    String prompt, {
    List<XFile> images = const [],
  }) async {
    isGeneratingNotifier.setIsGenerating();

    final imageUrl = await gemini.generateImage(prompt, images: images);

    if (imageUrl == null) {
      isGeneratingNotifier.setIsNotGenerating();
      return;
    }

    previousPrompt = prompt;
    previousImages = images;

    addImages(imageUrl);
    isGeneratingNotifier.setIsNotGenerating();

    if (state.length == 1) {
      generateImageWithPreviousPrompt();
    }
  }

  Future<void> generateImageWithPreviousPrompt() async {
    if (previousPrompt.isEmpty) return;

    await generateImages(previousPrompt, images: previousImages);
  }
}
