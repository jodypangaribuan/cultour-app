import 'package:flutter/material.dart';

/// A comprehensive responsive utility class that provides adaptive dimensions
/// based on screen size and device type
class ResponsiveUtils {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < _mobileBreakpoint;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= _desktopBreakpoint;
  }

  /// Get device type
  static DeviceType getDeviceType(BuildContext context) {
    final width = screenWidth(context);
    if (width < _mobileBreakpoint) return DeviceType.mobile;
    if (width < _tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Get responsive padding based on device type
  static double getResponsivePadding(BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive margin based on device type
  static double getResponsiveMargin(BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, {
    double mobile = 24.0,
    double tablet = 28.0,
    double desktop = 32.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(BuildContext context, {
    double mobile = 48.0,
    double tablet = 52.0,
    double desktop = 56.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive grid cross axis count
  static int getResponsiveCrossAxisCount(BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive width for containers/widgets
  static double getResponsiveWidth(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final deviceType = getDeviceType(context);
    final screenW = screenWidth(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile ?? screenW * 0.9;
      case DeviceType.tablet:
        return tablet ?? screenW * 0.8;
      case DeviceType.desktop:
        return desktop ?? screenW * 0.7;
    }
  }

  /// Get responsive height for containers/widgets
  static double getResponsiveHeight(BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final deviceType = getDeviceType(context);
    final screenH = screenHeight(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile ?? screenH * 0.7;
      case DeviceType.tablet:
        return tablet ?? screenH * 0.75;
      case DeviceType.desktop:
        return desktop ?? screenH * 0.8;
    }
  }

  /// Get responsive modal height
  static double getModalHeight(BuildContext context, {
    double mobileRatio = 0.7,
    double tabletRatio = 0.6,
    double desktopRatio = 0.5,
  }) {
    final screenH = screenHeight(context);
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return screenH * mobileRatio;
      case DeviceType.tablet:
        return screenH * tabletRatio;
      case DeviceType.desktop:
        return screenH * desktopRatio;
    }
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context, {
    double mobile = 12.0,
    double tablet = 16.0,
    double desktop = 20.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive card elevation
  static double getResponsiveElevation(BuildContext context, {
    double mobile = 2.0,
    double tablet = 4.0,
    double desktop = 6.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }

  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return kToolbarHeight;
      case DeviceType.tablet:
        return kToolbarHeight + 8;
      case DeviceType.desktop:
        return kToolbarHeight + 16;
    }
  }

  /// Get responsive bottom navigation bar height
  static double getBottomNavHeight(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return 80.0;
      case DeviceType.tablet:
        return 90.0;
      case DeviceType.desktop:
        return 100.0;
    }
  }

  /// Get responsive camera button size
  static double getCameraButtonSize(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return 56.0;
      case DeviceType.tablet:
        return 64.0;
      case DeviceType.desktop:
        return 72.0;
    }
  }

  /// Get responsive control button size (for maps)
  static double getControlButtonSize(BuildContext context) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return 44.0;
      case DeviceType.tablet:
        return 48.0;
      case DeviceType.desktop:
        return 52.0;
    }
  }

  /// Calculate width percentage of screen
  static double widthPercent(BuildContext context, double percent) {
    return screenWidth(context) * (percent / 100);
  }

  /// Calculate height percentage of screen
  static double heightPercent(BuildContext context, double percent) {
    return screenHeight(context) * (percent / 100);
  }

  /// Get responsive spacing between widgets
  static double getSpacing(BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    switch (getDeviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet;
      case DeviceType.desktop:
        return desktop;
    }
  }
}

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Extension on BuildContext for easy access to responsive utilities
extension ResponsiveContext on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils();
  
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  
  DeviceType get deviceType => ResponsiveUtils.getDeviceType(this);
  
  double get screenWidth => ResponsiveUtils.screenWidth(this);
  double get screenHeight => ResponsiveUtils.screenHeight(this);
  
  double responsivePadding({
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) => ResponsiveUtils.getResponsivePadding(this, 
      mobile: mobile, tablet: tablet, desktop: desktop);
      
  double responsiveFontSize({
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) => ResponsiveUtils.getResponsiveFontSize(this,
      mobile: mobile, tablet: tablet, desktop: desktop);
      
  double responsiveIconSize({
    double mobile = 24.0,
    double tablet = 28.0,
    double desktop = 32.0,
  }) => ResponsiveUtils.getResponsiveIconSize(this,
      mobile: mobile, tablet: tablet, desktop: desktop);
      
  int responsiveCrossAxisCount({
    int mobile = 2,
    int tablet = 3,
    int desktop = 4,
  }) => ResponsiveUtils.getResponsiveCrossAxisCount(this,
      mobile: mobile, tablet: tablet, desktop: desktop);
}
