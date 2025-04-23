import 'package:flutter/material.dart';

/// UI Constants for Travel Planner App
/// Based on modern travel app design trends

class AppColors {
  // Primary Colors - Matcha Theme
  static const Color primary = Color(0xFF4CAF50); // Matcha green
  static const Color primaryLight = Color(0xFF81C784); // Light matcha
  static const Color primaryDark = Color(0xFF388E3C); // Dark matcha
  
  // Accent Colors
  static const Color accent = Color(0xFFFFB74D); // Warm orange
  static const Color accentLight = Color(0xFFFFCC80);
  static const Color accentDark = Color(0xFFF57C00);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF424242);
  static const Color offWhite = Color(0xFFF7F8FC); // Added missing offWhite color
  
  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
  
  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentLight, accent, accentDark],
  );
  
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryLight, primaryDark],
  );
  
  // Helper method for color opacity
  static Color withValues({required Color color, required double alpha}) {
    return color.withOpacity(alpha);
  }
}

class AppDimensions {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;
  
  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusCircular = 999.0;
  
  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 40.0;
  static const double iconXXL = 48.0;
  
  // Button Heights
  static const double buttonHeightS = 32.0;
  static const double buttonHeightM = 40.0;
  static const double buttonHeightL = 48.0;
  
  // Elevation
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  
  // Card Elevation
  static const double cardElevation = 2.0;
  static const double cardElevationHover = 4.0;
}

class AppTextStyles {
  // Headings
  static const TextStyle headingXL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headingL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headingM = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headingS = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  // Body Text
  static const TextStyle bodyXL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    letterSpacing: 0.15,
  );
  
  static const TextStyle bodyL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    letterSpacing: 0.15,
  );
  
  static const TextStyle bodyM = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    letterSpacing: 0.15,
  );
  
  static const TextStyle bodyS = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    letterSpacing: 0.15,
  );
  
  // Button Text
  static const TextStyle buttonL = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static const TextStyle buttonM = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static const TextStyle buttonS = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  // Caption & Overline
  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    letterSpacing: 0.4,
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w500,
  );
}

class AppDecorations {
  // Input Decoration
  static InputDecoration inputDecoration({
    required String label,
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: BorderSide(color: AppColors.mediumGrey.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: BorderSide(color: AppColors.mediumGrey.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      filled: true,
      fillColor: AppColors.white,
    );
  }
  
  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingL,
      vertical: AppDimensions.paddingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    ),
    minimumSize: const Size(200, AppDimensions.buttonHeightM),
  );
  
  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.primary,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingL,
      vertical: AppDimensions.paddingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      side: const BorderSide(color: AppColors.primary),
    ),
    minimumSize: const Size(200, AppDimensions.buttonHeightM),
  );
  
  static final ButtonStyle accentButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.accent,
    foregroundColor: AppColors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingL,
      vertical: AppDimensions.paddingM,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
    ),
    minimumSize: const Size(200, AppDimensions.buttonHeightM),
  );
  
  // Card Decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
    boxShadow: [
      BoxShadow(
        color: AppColors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
} 