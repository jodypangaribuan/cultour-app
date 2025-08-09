import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../domain/entities/language.dart';
import '../bloc/translation_bloc.dart';

class LiveTranslationWidget extends StatefulWidget {
  const LiveTranslationWidget({super.key});

  @override
  State<LiveTranslationWidget> createState() => _LiveTranslationWidgetState();
}

class _LiveTranslationWidgetState extends State<LiveTranslationWidget> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  Language _fromLanguage = Language.supportedLanguages[0]; // Auto Detect
  Language _toLanguage = Language.targetLanguages[2]; // Batak Karo

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _inputController.removeListener(_onInputChanged);
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    if (_inputController.text.trim().isNotEmpty) {
      _translateText();
    } else {
      _outputController.clear();
    }
  }

  void _translateText() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    context.read<TranslationBloc>().add(TranslateTextEvent(
      text: text,
      targetLanguage: _toLanguage.code,
      sourceLanguage: _fromLanguage.code != 'auto' ? _fromLanguage.code : null,
    ));
  }

  void _swapLanguages() {
    // Don't swap if source is auto-detect or target would become auto-detect
    if (_fromLanguage.code == 'auto' || _toLanguage.code == 'auto') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot swap when using Auto Detect'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      final temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
      
      final tempText = _inputController.text;
      _inputController.text = _outputController.text;
      _outputController.text = tempText;
    });

    context.read<TranslationBloc>().add(SwapLanguagesEvent(
      newSourceLanguage: _fromLanguage.code,
      newTargetLanguage: _toLanguage.code,
    ));

    if (_inputController.text.trim().isNotEmpty) {
      _translateText();
    }
  }

  void _copyToClipboard() {
    if (_outputController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _outputController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Translation copied to clipboard!'),
          backgroundColor: AppColors.primary,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showLanguageSelector({required bool isSourceLanguage}) {
    final languages = isSourceLanguage ? Language.supportedLanguages : Language.targetLanguages;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSourceLanguage ? 'Select source language' : 'Select target language',
              style: const TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return ListTile(
                    title: Text(language.displayName),
                    subtitle: Text(language.code.toUpperCase()),
                    leading: language.code == 'auto' 
                        ? const Icon(Icons.auto_fix_high, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        if (isSourceLanguage) {
                          _fromLanguage = language;
                        } else {
                          _toLanguage = language;
                        }
                      });
                      Navigator.pop(context);
                      if (_inputController.text.trim().isNotEmpty) {
                        _translateText();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TranslationBloc, TranslationState>(
      listener: (context, state) {
        if (state is TranslationSuccess) {
          _outputController.text = state.translation.translatedText;
        } else if (state is TranslationError) {
          _outputController.text = 'Translation error: ${state.message}';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is TranslationLoading) {
          _outputController.text = 'Translating...';
        }
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 3),
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            children: [
              // Language Selection Row
              Row(
                children: [
                  // From Language
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showLanguageSelector(isSourceLanguage: true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: AppDimensions.paddingS,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _fromLanguage.displayName,
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontS,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingM),
                  // Swap Button
                  GestureDetector(
                    onTap: _swapLanguages,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.swap_horiz,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingM),
                  // To Language
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showLanguageSelector(isSourceLanguage: false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: AppDimensions.paddingS,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _toLanguage.displayName,
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontS,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingM),
              // Input Text Area
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: _inputController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter ${_fromLanguage.displayName} text...',
                        hintStyle: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontL,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.fromLTRB(
                          AppDimensions.paddingM,
                          AppDimensions.paddingM,
                          48,
                          AppDimensions.paddingM,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: AppDimensions.fontL,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    // Clear Button
                    Positioned(
                      top: AppDimensions.paddingS,
                      right: AppDimensions.paddingS,
                      child: GestureDetector(
                        onTap: () {
                          _inputController.clear();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              // Output Text Area
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: _outputController,
                      maxLines: 4,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Translation will appear here...',
                        hintStyle: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontL,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.fromLTRB(
                          AppDimensions.paddingM,
                          AppDimensions.paddingM,
                          80,
                          AppDimensions.paddingM,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: AppDimensions.fontL,
                        color: AppColors.primary,
                      ),
                    ),
                    // Action Buttons
                    Positioned(
                      bottom: AppDimensions.paddingS,
                      right: AppDimensions.paddingS,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Copy Button
                          GestureDetector(
                            onTap: _copyToClipboard,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.copy,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingS),
                          // Share Button
                          GestureDetector(
                            onTap: () {
                              // Handle share action
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Translation shared!'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.share,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}