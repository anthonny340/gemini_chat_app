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
}
