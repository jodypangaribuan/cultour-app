import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleTranslateService {
  static const String _baseUrl = 'https://translation.googleapis.com/language/translate/v2';
  final String _apiKey;

  GoogleTranslateService({required String apiKey}) : _apiKey = apiKey;

  /// Translates text from one language to another using Google Cloud Translate API
  /// 
  /// [text] - The text to translate
  /// [targetLanguage] - Target language code (e.g., 'en', 'id', 'btk')
  /// [sourceLanguage] - Source language code (optional, will auto-detect if not provided)
  /// 
  /// Returns the translated text or throws an exception if translation fails
  Future<String> translateText({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'q': text,
        'target': targetLanguage,
        'format': 'text',
      };

      if (sourceLanguage != null) {
        requestBody['source'] = sourceLanguage;
      }

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-goog-api-key': _apiKey,
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> translations = responseData['data']['translations'];
        
        if (translations.isNotEmpty) {
          return translations[0]['translatedText'] as String;
        } else {
          throw Exception('No translation found');
        }
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Translation failed: ${errorData['error']['message']}');
      }
    } catch (e) {
      throw Exception('Translation error: $e');
    }
  }

  /// Detects the language of the given text
  /// 
  /// [text] - The text to analyze
  /// 
  /// Returns the detected language code
  Future<String> detectLanguage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/detect'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-goog-api-key': _apiKey,
        },
        body: json.encode({
          'q': text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> detections = responseData['data']['detections'][0];
        
        if (detections.isNotEmpty) {
          return detections[0]['language'] as String;
        } else {
          throw Exception('No language detected');
        }
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Language detection failed: ${errorData['error']['message']}');
      }
    } catch (e) {
      throw Exception('Language detection error: $e');
    }
  }

  /// Gets list of supported languages
  /// 
  /// [targetLanguage] - Language code for language names (optional, defaults to 'en')
  /// 
  /// Returns a map of language codes to language names
  Future<Map<String, String>> getSupportedLanguages([String targetLanguage = 'en']) async {
    try {
      final response = await http.get(
        Uri.parse('https://translation.googleapis.com/language/translate/v2/languages?target=$targetLanguage'),
        headers: {
          'X-goog-api-key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> languages = responseData['data']['languages'];
        
        final Map<String, String> supportedLanguages = {};
        for (final language in languages) {
          supportedLanguages[language['language']] = language['name'];
        }
        
        return supportedLanguages;
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Failed to get supported languages: ${errorData['error']['message']}');
      }
    } catch (e) {
      throw Exception('Error getting supported languages: $e');
    }
  }
}
