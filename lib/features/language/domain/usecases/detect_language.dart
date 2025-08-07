import 'package:equatable/equatable.dart';

import '../../../../core/utils/typedef.dart';
import '../repositories/translation_repository.dart';

class DetectLanguage {
  final TranslationRepository repository;

  DetectLanguage(this.repository);

  ResultFuture<String> call(DetectLanguageParams params) async {
    return await repository.detectLanguage(params.text);
  }
}

class DetectLanguageParams extends Equatable {
  final String text;

  const DetectLanguageParams({required this.text});

  @override
  List<Object?> get props => [text];
}
