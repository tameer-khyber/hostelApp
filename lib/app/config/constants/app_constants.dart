/// Application-wide constants for spacing, sizing, and styling
class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // ==================== SPACING ====================
  static const double spacingXs = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ==================== BORDER RADIUS ====================
  static const double radiusXs = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusXxl = 30.0;
  static const double radiusFull = 999.0;

  // ==================== ELEVATION ====================
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // ==================== ANIMATION DURATION ====================
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ==================== ICON SIZES ====================
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 20.0;
  static const double iconSizeL = 24.0;
  static const double iconSizeXl = 32.0;

  // ==================== BUTTON HEIGHTS ====================
  static const double buttonHeightS = 45.0;
  static const double buttonHeightM = 55.0;
  static const double buttonHeightL = 65.0;

  // ==================== OPACITY ====================
  static const double opacityDisabled = 0.5;
  static const double opacityLight = 0.3;
  static const double opacityMedium = 0.6;
  static const double opacityHeavy = 0.9;

  // ==================== BLUR ====================
  static const double blurLight = 10.0;
  static const double blurMedium = 20.0;
  static const double blurHeavy = 30.0;
}
