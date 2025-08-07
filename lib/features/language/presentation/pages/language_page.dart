import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/di/injection_container.dart';
import '../widgets/language_feature_card.dart';
import '../widgets/live_translation_widget.dart';
import '../bloc/translation_bloc.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TranslationBloc>(),
      child: Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Custom Header
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.paddingM,
                  AppDimensions.paddingM,
                  AppDimensions.paddingM,
                  AppDimensions.paddingS,
                ),
                child: Center(
                  child: Text(
                    'Language Tutor',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live Translation Widget - Clean layout
                  const SizedBox(height: AppDimensions.paddingM),
                  const LiveTranslationWidget(),
                  const SizedBox(height: AppDimensions.paddingXL),
                  // Learn Batak Language Section - Now at the bottom
                  const Text(
                    'Learn Batak Language',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  const Text(
                    'Engage in interactive lessons, practice with our AI chat, and use the live translator to master the Batak language.',
                    style: TextStyle(
                      fontSize: AppDimensions.fontL,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),
                  // Feature Cards Grid
                  Row(
                    children: [
                      Expanded(
                        child: LanguageFeatureCard(
                          icon: Icons.menu_book,
                          title: 'Interactive Lessons',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Interactive Lessons coming soon!'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Expanded(
                        child: LanguageFeatureCard(
                          icon: Icons.chat_bubble_outline,
                          title: 'AI Chat Practice',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('AI Chat Practice coming soon!'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
