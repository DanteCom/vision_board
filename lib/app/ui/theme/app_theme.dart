import 'package:vision_board/app/ui/theme/app_text_styles.dart';
import 'package:vision_board/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    fontFamily: 'WorkSans',
    scaffoldBackgroundColor: AppColors.white,
  );

  static final titleTextFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    hintText: 'Vision Name',
    hintStyle: AppTextStyles.s14w400ws,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: AppColors.black20),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: AppColors.black20),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: AppColors.black20),
    ),
  );

  static final noteTextFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(16),
    hintText: 'Text note',
    hintStyle: AppTextStyles.s14w400ws.copyWith(color: AppColors.black40),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.black20),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.black20),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors.black20),
    ),
  );

  static final containerShadow = BoxShadow(
    blurRadius: 20,
    spreadRadius: 0,
    offset: const Offset(0, 10),
    color: AppColors.black.withOpacity(0.05),
  );
}
