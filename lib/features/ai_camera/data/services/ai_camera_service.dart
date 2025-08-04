import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/ai_detection_result.dart';

class AICameraService {
  Future<AIDetectionResult?> detectImage(File imageFile) async {
    final url = Uri.parse('https://your-api-url.com/detect'); // Ganti dengan endpoint asli

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AIDetectionResult.fromJson(data);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error sending request: $e');
      return null;
    }
  }
}
