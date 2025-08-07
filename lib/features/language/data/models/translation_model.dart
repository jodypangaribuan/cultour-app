import '../../domain/entities/translation.dart';

class TranslationModel extends Translation {
  const TranslationModel({
    required super.originalText,
    required super.translatedText,
    required super.sourceLanguage,
    required super.targetLanguage,
    required super.timestamp,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      originalText: json['originalText'] as String,
      translatedText: json['translatedText'] as String,
      sourceLanguage: json['sourceLanguage'] as String,
      targetLanguage: json['targetLanguage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalText': originalText,
      'translatedText': translatedText,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory TranslationModel.fromEntity(Translation translation) {
    return TranslationModel(
      originalText: translation.originalText,
      translatedText: translation.translatedText,
      sourceLanguage: translation.sourceLanguage,
      targetLanguage: translation.targetLanguage,
      timestamp: translation.timestamp,
    );
  }
}
