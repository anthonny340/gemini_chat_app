import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiImpl {
  final Dio _http = Dio(BaseOptions(baseUrl: dotenv.env["ENDPOINT_API"] ?? ''));
  Future<String> getResponse(String prompt) async {
    final body = jsonEncode({"prompt": prompt});
    final response = await _http.post('/basic-prompt', data: body);

    // print(response.data);
    return response.data['content'];
  }

  Stream<String> getResponseStream(String prompt) async* {
    // TODO Tener presente que enviaremos imagenes
    //! Multipart
    final body = jsonEncode({"prompt": prompt});
    final response = await _http.post(
      '/basic-prompt-stream',
      data: body,
      options: Options(responseType: ResponseType.stream),
    );

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
}
