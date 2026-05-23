import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
types.User geminiUser(Ref ref) {
  const geminiUser = types.User(
    id: "gemini-id",
    firstName: "Gemini",
    lastName: "Flash Model",
    imageUrl:
        "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/google-gemini-icon.png",
  );

  return geminiUser;
}
