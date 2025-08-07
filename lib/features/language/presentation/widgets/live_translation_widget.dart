import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';

class LiveTranslationWidget extends StatefulWidget {
  const LiveTranslationWidget({super.key});

  @override
  State<LiveTranslationWidget> createState() => _LiveTranslationWidgetState();
}

class _LiveTranslationWidgetState extends State<LiveTranslationWidget> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _fromLanguage = 'English';
  String _toLanguage = 'Batak';

  @override
  void initState() {
    super.initState();
    _inputController.text = 'Horas!';
    _outputController.text = 'Hello!';
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _swapLanguages() {
    setState(() {
      final temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
      
      final tempText = _inputController.text;
      _inputController.text = _outputController.text;
      _outputController.text = tempText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        children: [
          // Language Selection Row
          Row(
            children: [
              // From Language
              Expanded(
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
                          _fromLanguage,
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
                          _toLanguage,
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
                    hintText: 'Enter $_fromLanguage text...',
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
                        onTap: () {
                          // Handle copy action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Translation copied!'),
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
    );
  }
}
