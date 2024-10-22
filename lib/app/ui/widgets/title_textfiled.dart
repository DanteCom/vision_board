import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleTextFiled extends StatelessWidget {
  const TitleTextFiled({
    super.key,
    required this.controller,
    this.bottomScrollPadding,
    required this.onChanged,
    this.topScrollPadding,
  });
  final TextEditingController controller;
  final Function(String?) onChanged;
  final double? bottomScrollPadding;
  final double? topScrollPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            cursorColor: AppColors.main,
            scrollPadding:
                EdgeInsets.only(top: topScrollPadding ?? 120).copyWith(
              bottom: bottomScrollPadding,
            ),
            cursorHeight: 20,
            style: AppTextStyles.s14w400ws.copyWith(
              color: AppColors.black90,
            ),
            decoration: AppTheme.titleTextFieldDecoration,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
          ),
          Positioned(
            right: 16,
            top: 15,
            child: Center(
              child: Text(
                '${controller.text.length}/30',
                style: AppTextStyles.s12w400ws.copyWith(
                  color: AppColors.black60,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
