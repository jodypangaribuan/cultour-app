import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/translation.dart';
import '../../domain/usecases/translate_text.dart';
import '../../domain/usecases/detect_language.dart';

// Events
abstract class TranslationEvent extends Equatable {
  const TranslationEvent();

  @override
  List<Object?> get props => [];
}

class TranslateTextEvent extends TranslationEvent {
  final String text;
  final String targetLanguage;
  final String? sourceLanguage;

  const TranslateTextEvent({
    required this.text,
    required this.targetLanguage,
    this.sourceLanguage,
  });

  @override
  List<Object?> get props => [text, targetLanguage, sourceLanguage];
}

class DetectLanguageEvent extends TranslationEvent {
  final String text;

  const DetectLanguageEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class SwapLanguagesEvent extends TranslationEvent {
  final String newSourceLanguage;
  final String newTargetLanguage;

  const SwapLanguagesEvent({
    required this.newSourceLanguage,
    required this.newTargetLanguage,
  });

  @override
  List<Object?> get props => [newSourceLanguage, newTargetLanguage];
}

class ClearTranslationEvent extends TranslationEvent {
  const ClearTranslationEvent();
}

// States
abstract class TranslationState extends Equatable {
  const TranslationState();

  @override
  List<Object?> get props => [];
}

class TranslationInitial extends TranslationState {}

class TranslationLoading extends TranslationState {}

class LanguageDetectionLoading extends TranslationState {}

class TranslationSuccess extends TranslationState {
  final Translation translation;

  const TranslationSuccess(this.translation);

  @override
  List<Object?> get props => [translation];
}

class LanguageDetected extends TranslationState {
  final String languageCode;

  const LanguageDetected(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class LanguagesSwapped extends TranslationState {
  final String newSourceLanguage;
  final String newTargetLanguage;

  const LanguagesSwapped({
    required this.newSourceLanguage,
    required this.newTargetLanguage,
  });

  @override
  List<Object?> get props => [newSourceLanguage, newTargetLanguage];
}

class TranslationError extends TranslationState {
  final String message;

  const TranslationError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  final TranslateText _translateText;
  final DetectLanguage _detectLanguage;

  TranslationBloc({
    required TranslateText translateText,
    required DetectLanguage detectLanguage,
  })  : _translateText = translateText,
        _detectLanguage = detectLanguage,
        super(TranslationInitial()) {
    on<TranslateTextEvent>(_onTranslateText);
    on<DetectLanguageEvent>(_onDetectLanguage);
    on<SwapLanguagesEvent>(_onSwapLanguages);
    on<ClearTranslationEvent>(_onClearTranslation);
  }

  Future<void> _onTranslateText(
    TranslateTextEvent event,
    Emitter<TranslationState> emit,
  ) async {
    if (event.text.trim().isEmpty) {
      emit(TranslationError('Please enter text to translate'));
      return;
    }

    emit(TranslationLoading());

    final result = await _translateText(TranslateTextParams(
      text: event.text,
      targetLanguage: event.targetLanguage,
      sourceLanguage: event.sourceLanguage,
    ));

    result.fold(
      (failure) => emit(TranslationError(failure.message)),
      (translation) => emit(TranslationSuccess(translation)),
    );
  }

  Future<void> _onDetectLanguage(
    DetectLanguageEvent event,
    Emitter<TranslationState> emit,
  ) async {
    emit(LanguageDetectionLoading());

    final result = await _detectLanguage(DetectLanguageParams(text: event.text));

    result.fold(
      (failure) => emit(TranslationError(failure.message)),
      (languageCode) => emit(LanguageDetected(languageCode)),
    );
  }

  void _onSwapLanguages(
    SwapLanguagesEvent event,
    Emitter<TranslationState> emit,
  ) {
    emit(LanguagesSwapped(
      newSourceLanguage: event.newSourceLanguage,
      newTargetLanguage: event.newTargetLanguage,
    ));
  }

  void _onClearTranslation(
    ClearTranslationEvent event,
    Emitter<TranslationState> emit,
  ) {
    emit(TranslationInitial());
  }
}
