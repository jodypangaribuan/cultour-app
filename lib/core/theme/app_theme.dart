import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../utils/responsive_utils.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.primary,
        tertiary: AppColors.accent,
        onTertiary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.border,
        surfaceVariant: AppColors.backgroundLight,
        onSurfaceVariant: AppColors.textSecondary,
      ),
      fontFamily: 'Roboto',
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      cardTheme: _cardTheme,
      dividerTheme: _dividerTheme,
    );
  }

  /// Get responsive theme data based on context
  static ThemeData getResponsiveTheme(BuildContext context) {
    final base = lightTheme;
    
    return base.copyWith(
      textTheme: _buildResponsiveTextTheme(context),
      appBarTheme: _buildResponsiveAppBarTheme(context),
      elevatedButtonTheme: _buildResponsiveElevatedButtonTheme(context),
      inputDecorationTheme: _buildResponsiveInputDecorationTheme(context),
      bottomNavigationBarTheme: _buildResponsiveBottomNavigationBarTheme(context),
      cardTheme: _buildResponsiveCardTheme(context),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: AppDimensions.fontXXXL,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: AppDimensions.fontXXL,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    displaySmall: TextStyle(
      fontSize: AppDimensions.fontXL,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: AppDimensions.fontL,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: AppDimensions.fontL,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: AppDimensions.fontM,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: AppDimensions.fontS,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
    labelLarge: TextStyle(
      fontSize: AppDimensions.fontM,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: AppDimensions.fontS,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: AppDimensions.fontXS,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: AppDimensions.fontXXL,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
  );



  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      textStyle: const TextStyle(
        fontSize: AppDimensions.fontL,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.backgroundLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingM,
      vertical: AppDimensions.paddingM,
    ),
    hintStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontSize: AppDimensions.fontL,
    ),
  );

  static const BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: AppDimensions.fontS,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: AppDimensions.fontS,
    ),
  );

  static final CardThemeData _cardTheme = CardThemeData(
    color: AppColors.surface,
    elevation: 2,
    shadowColor: AppColors.textSecondary.withOpacity(0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingS,
      vertical: AppDimensions.paddingXS,
    ),
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  );

  // Responsive theme builders
  static TextTheme _buildResponsiveTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xxxl),
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xxl),
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xs),
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }

  static AppBarTheme _buildResponsiveAppBarTheme(BuildContext context) {
    return AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: ResponsiveUtils.getAppBarHeight(context),
      titleTextStyle: TextStyle(
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xxl),
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  static ElevatedButtonThemeData _buildResponsiveElevatedButtonTheme(BuildContext context) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.l),
          vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
          ),
        ),
        textStyle: TextStyle(
          fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
          fontWeight: FontWeight.w600,
        ),
        minimumSize: Size(
          double.infinity,
          ResponsiveUtils.getResponsiveButtonHeight(context),
        ),
      ),
    );
  }

  static InputDecorationTheme _buildResponsiveInputDecorationTheme(BuildContext context) {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
        ),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
        ),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
        ),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
      ),
      hintStyle: TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildResponsiveBottomNavigationBarTheme(BuildContext context) {
    return BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
      ),
    );
  }

  static CardThemeData _buildResponsiveCardTheme(BuildContext context) {
    return CardThemeData(
      color: AppColors.surface,
      elevation: ResponsiveUtils.getResponsiveElevation(context),
      shadowColor: AppColors.textSecondary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.l),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
        vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs),
      ),
    );
  }
}
