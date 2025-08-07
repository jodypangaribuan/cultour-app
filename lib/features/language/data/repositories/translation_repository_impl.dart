import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/translation.dart';
import '../../domain/repositories/translation_repository.dart';
import '../models/translation_model.dart';
import '../services/google_translate_service.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  final GoogleTranslateService translateService;

  TranslationRepositoryImpl({required this.translateService});

  @override
  Future<Either<Failure, Translation>> translateText({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async {
    try {
      final translatedText = await translateService.translateText(
        text: text,
        targetLanguage: targetLanguage,
        sourceLanguage: sourceLanguage,
      );

      // Detect source language if not provided
      String detectedSourceLanguage = sourceLanguage ?? 'auto';
      if (sourceLanguage == null) {
        try {
          detectedSourceLanguage = await translateService.detectLanguage(text);
        } catch (e) {
          // If detection fails, use 'auto'
          detectedSourceLanguage = 'auto';
        }
      }

      final translation = TranslationModel(
        originalText: text,
        translatedText: translatedText,
        sourceLanguage: detectedSourceLanguage,
        targetLanguage: targetLanguage,
        timestamp: DateTime.now(),
      );

      return Right(translation);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> detectLanguage(String text) async {
    try {
      final detectedLanguage = await translateService.detectLanguage(text);
      return Right(detectedLanguage);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> getSupportedLanguages([String targetLanguage = 'en']) async {
    try {
      final supportedLanguages = await translateService.getSupportedLanguages(targetLanguage);
      return Right(supportedLanguages);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
