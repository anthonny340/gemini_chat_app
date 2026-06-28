import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class GeminiImpl {
  final Dio _http = Dio(BaseOptions(baseUrl: dotenv.env["ENDPOINT_API"] ?? ''));
  Future<String> getResponse(String prompt) async {
    final body = jsonEncode({"prompt": prompt});
    final response = await _http.post('/basic-prompt', data: body);

    // print(response.data);
    return response.data['content'];
  }

  Stream<String> getResponseStream(
    String prompt, {
    List<XFile> files = const [],
  }) async* {
    yield* _getStreamResponse(
        endponint: '/basic-prompt-stream-images', prompt: prompt, files: files);
  }

  Stream<String> getChatStream(
    String prompt,
    String chatId, {
    List<XFile> files = const [],
  }) async* {
    final Map<String, dynamic> formFields = {'chatId': chatId};

    yield* _getStreamResponse(
      endponint: '/chat-stream',
      prompt: prompt,
      files: files,
      formFields: formFields,
    );
  }

  Stream<String> _getStreamResponse({
    required String endponint,
    required String prompt,
    List<XFile> files = const [],
    Map<String, dynamic> formFields = const {},
  }) async* {
    //! Multipart
    final formData = FormData();
    formData.fields.add(MapEntry("prompt", prompt));
    for (final entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }

    //! Archivos a subir
    if (files.isNotEmpty) {
      for (final file in files) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(file.path, filename: file.name),
        ));
      }
    }

    //! Peticion POST
    final response = await _http.post(
      endponint,
      data: formData,
      options: Options(responseType: ResponseType.stream),
    );

    //! Le damos una firma a la respuesta stream
    final stream = response.data.stream as Stream<List<int>>;
    String buffer = '';

    await for (final bytes in stream) {
      buffer += utf8.decode(bytes, allowMalformed: true);

      final events = buffer
          .split('\n\n'); // Cada chunk Esta separado asi, desde el backend

      buffer = events.removeLast();

      for (final event in events) {
        if (!event.startsWith('data:')) continue;

        final jsonString = event.replaceFirst('data:', '').trim();
        final json = jsonDecode(
            jsonString); // Para convertir el texto JSON en un objeto Dart

        final chunk = json['chunk'];
        final done = json['done'] == true;
        final success = json['success'] == true;
        final error = json['error'];

        if (!success) {
          print('''
              ----Error en un chunk----
              chunk: $chunk,
              error: $error
                ''');
        }

        if (chunk != null) {
          yield chunk;
        }

        if (done) {
          print('Stream finalizado');
        }
      }
    }
  }

  Future<String?> generateImage(String prompt,
      {List<XFile> images = const []}) async {
    final formData = FormData();

    formData.fields.add(MapEntry('prompt', prompt));
    for (final image in images) {
      formData.files.add(MapEntry('images',
          await MultipartFile.fromFile(image.path, filename: image.name)));
    }

    try {
      final response = await _http.post('/generate-image', data: formData);

      return response.data['chunk'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  //! TODO Implementar este metodo
  Stream<Map<String, dynamic>> getGenerateImageChatStream(
    String prompt,
    String chatId, {
    List<XFile> files = const [],
  }) async* {
    final Map<String, dynamic> formFields = {'chatId': chatId};

    yield* _getStreamResponseWithImage(
      endponint: '/chat-generate-image',
      prompt: prompt,
      files: files,
      formFields: formFields,
    );
  }

  Stream<Map<String, dynamic>> _getStreamResponseWithImage({
    required String endponint,
    required String prompt,
    List<XFile> files = const [],
    Map<String, dynamic> formFields = const {},
  }) async* {
    //! Multipart
    final formData = FormData();
    formData.fields.add(MapEntry("prompt", prompt));
    for (final entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }

    //! Archivos a subir
    if (files.isNotEmpty) {
      for (final file in files) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(file.path, filename: file.name),
        ));
      }
    }

    //! Peticion POST
    final response = await _http.post(
      endponint,
      data: formData,
      options: Options(responseType: ResponseType.stream),
    );

    //! Le damos una firma a la respuesta stream
    final stream = response.data.stream as Stream<List<int>>;
    String buffer = '';

    await for (final bytes in stream) {
      buffer += utf8.decode(bytes, allowMalformed: true);

      final events = buffer
          .split('\n\n'); // Cada chunk Esta separado asi, desde el backend

      buffer = events.removeLast();

      for (final event in events) {
        if (!event.startsWith('data:')) continue;

        final jsonString = event.replaceFirst('data:', '').trim();
        final json = jsonDecode(
            jsonString); // Para convertir el texto JSON en un objeto Dart

        final chunk = json['chunk'];
        final type = json['type'];
        final done = json['done'] == true;

        switch (type) {
          case 'text':
            if (chunk != null) {
              yield {
                'type': 'text',
                'chunk': chunk,
                'done': false,
              };
            }
            break;
          case 'image':
            if (chunk != null) {
              yield {
                'type': 'image',
                'chunk': chunk,
                'done': false,
              };
            }
            break;
          case 'error':
            yield {
              'type': 'error',
              'chunk': chunk ?? 'Error desconocido',
              'done': true,
            };
            break;
          case 'end':
            if (done) {
              yield {
                'type': 'end',
                'chunk': chunk ?? '',
                'done': true,
              };
              print('Stream finalizado');
            }
            break;
        }
      }
    }
  }
}
