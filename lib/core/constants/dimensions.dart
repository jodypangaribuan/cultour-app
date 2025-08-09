import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class AppDimensions {
  // Base dimensions for mobile devices (used as fallback)
  // Padding and Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  
  // Icon Sizes (base)
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Component Heights (base)
  static const double searchBarHeight = 48.0;
  static const double bottomNavHeight = 80.0;
  static const double buttonHeight = 48.0;
  
  // Font Sizes (base)
  static const double fontXS = 10.0;
  static const double fontS = 12.0;
  static const double fontM = 14.0;
  static const double fontL = 16.0;
  static const double fontXL = 18.0;
  static const double fontXXL = 20.0;
  static const double fontXXXL = 24.0;

  // Responsive methods
  
  /// Get responsive padding based on context
  static double getResponsivePadding(BuildContext context, ResponsivePaddingSize size) {
    switch (size) {
      case ResponsivePaddingSize.xs:
        return ResponsiveUtils.getResponsivePadding(context, mobile: 4, tablet: 6, desktop: 8);
      case ResponsivePaddingSize.s:
        return ResponsiveUtils.getResponsivePadding(context, mobile: 8, tablet: 10, desktop: 12);
      case ResponsivePaddingSize.m:
        return ResponsiveUtils.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24);
      case ResponsivePaddingSize.l:
        return ResponsiveUtils.getResponsivePadding(context, mobile: 24, tablet: 28, desktop: 32);
      case ResponsivePaddingSize.xl:
        return ResponsiveUtils.getResponsivePadding(context, mobile: 32, tablet: 40, desktop: 48);
    }
  }

  /// Get responsive border radius based on context
  static double getResponsiveBorderRadius(BuildContext context, ResponsiveRadiusSize size) {
    switch (size) {
      case ResponsiveRadiusSize.s:
        return ResponsiveUtils.getResponsiveBorderRadius(context, mobile: 8, tablet: 10, desktop: 12);
      case ResponsiveRadiusSize.m:
        return ResponsiveUtils.getResponsiveBorderRadius(context, mobile: 12, tablet: 14, desktop: 16);
      case ResponsiveRadiusSize.l:
        return ResponsiveUtils.getResponsiveBorderRadius(context, mobile: 16, tablet: 18, desktop: 20);
      case ResponsiveRadiusSize.xl:
        return ResponsiveUtils.getResponsiveBorderRadius(context, mobile: 24, tablet: 28, desktop: 32);
    }
  }

  /// Get responsive icon size based on context
  static double getResponsiveIconSize(BuildContext context, ResponsiveIconSize size) {
    switch (size) {
      case ResponsiveIconSize.s:
        return ResponsiveUtils.getResponsiveIconSize(context, mobile: 16, tablet: 18, desktop: 20);
      case ResponsiveIconSize.m:
        return ResponsiveUtils.getResponsiveIconSize(context, mobile: 24, tablet: 26, desktop: 28);
      case ResponsiveIconSize.l:
        return ResponsiveUtils.getResponsiveIconSize(context, mobile: 32, tablet: 36, desktop: 40);
      case ResponsiveIconSize.xl:
        return ResponsiveUtils.getResponsiveIconSize(context, mobile: 48, tablet: 52, desktop: 56);
    }
  }

  /// Get responsive font size based on context
  static double getResponsiveFontSize(BuildContext context, ResponsiveFontSize size) {
    switch (size) {
      case ResponsiveFontSize.xs:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 10, tablet: 11, desktop: 12);
      case ResponsiveFontSize.s:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 13, desktop: 14);
      case ResponsiveFontSize.m:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 14, tablet: 15, desktop: 16);
      case ResponsiveFontSize.l:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 17, desktop: 18);
      case ResponsiveFontSize.xl:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 22);
      case ResponsiveFontSize.xxl:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 20, tablet: 22, desktop: 24);
      case ResponsiveFontSize.xxxl:
        return ResponsiveUtils.getResponsiveFontSize(context, mobile: 24, tablet: 26, desktop: 28);
    }
  }
}

enum ResponsivePaddingSize { xs, s, m, l, xl }
enum ResponsiveRadiusSize { s, m, l, xl }
enum ResponsiveIconSize { s, m, l, xl }
enum ResponsiveFontSize { xs, s, m, l, xl, xxl, xxxl }
