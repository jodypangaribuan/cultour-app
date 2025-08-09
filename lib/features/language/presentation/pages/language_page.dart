import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/di/injection_container.dart';

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
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                  AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                  AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                  AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                ),
                child: Center(
                  child: Text(
                    'Language Tutor',
                    style: TextStyle(
                      fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
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
              padding: EdgeInsets.all(
                AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live Translation Widget - Clean layout
                  SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m)),
                  const LiveTranslationWidget(),
                  SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xl)),

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
