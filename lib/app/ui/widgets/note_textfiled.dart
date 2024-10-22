import 'package:vision_board/app/ui/theme/app_text_styles.dart';
import 'package:vision_board/app/ui/theme/app_colors.dart';
import 'package:vision_board/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteTextFiled extends StatelessWidget {
  const NoteTextFiled({
    super.key,
    required this.controller,
    this.bottomScrollPadding,
    required this.onChanged,
    this.topScrollPadding,
    this.enabled,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;
  final double? bottomScrollPadding;
  final double? topScrollPadding;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      cursorColor: AppColors.main,
      scrollPadding:
          EdgeInsets.only(bottom: bottomScrollPadding ?? 300).copyWith(
        top: topScrollPadding,
      ),
      cursorHeight: 20,
      maxLines: 10,
      style: AppTextStyles.s14w400ws.copyWith(
        color: AppColors.black90,
      ),
      decoration: AppTheme.noteTextFieldDecoration,
      inputFormatters: [LengthLimitingTextInputFormatter(300)],
    );
  }
}
