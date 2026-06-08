import 'package:flutter/material.dart';

final String _apiUrl = "http://localhost:3000";
String getApiUrl() => _apiUrl;
class AppColors {
  static const Color primary = Color(0xFF1CB0F6);
  static const Color textBlack = Color(0xFF4C4C4C);
  static const Color textWhite = Colors.white;
 static const Color errorColor = Color(0xFFEA2B2B);
}

class AppTextStyles {
  static const TextStyle wordHeader = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: 0.5,
  );
  static const TextStyle wordTitle= TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyDefinition = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    letterSpacing: 0.8,
  );

}
