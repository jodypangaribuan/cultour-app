import 'package:equatable/equatable.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/translation.dart';
import '../repositories/translation_repository.dart';

class TranslateText {
  final TranslationRepository repository;

  TranslateText(this.repository);

  ResultFuture<Translation> call(TranslateTextParams params) async {
    return await repository.translateText(
      text: params.text,
      targetLanguage: params.targetLanguage,
      sourceLanguage: params.sourceLanguage,
    );
  }
}

class TranslateTextParams extends Equatable {
  final String text;
  final String targetLanguage;
  final String? sourceLanguage;

  const TranslateTextParams({
    required this.text,
    required this.targetLanguage,
    this.sourceLanguage,
  });

  @override
  List<Object?> get props => [text, targetLanguage, sourceLanguage];
}
