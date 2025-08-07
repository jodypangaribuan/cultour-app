import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/translation.dart';

abstract class TranslationRepository {
  /// Translates text from source language to target language
  Future<Either<Failure, Translation>> translateText({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  });

  /// Detects the language of the given text
  Future<Either<Failure, String>> detectLanguage(String text);

  /// Gets list of supported languages
  Future<Either<Failure, Map<String, String>>> getSupportedLanguages([String targetLanguage = 'en']);
}
