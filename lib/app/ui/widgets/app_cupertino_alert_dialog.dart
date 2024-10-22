import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class AppCupertinoAlertDioalg extends StatelessWidget {
  const AppCupertinoAlertDioalg({
    super.key,
    required this.title,
    required this.content,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.onPressed,
  });
  final String title;
  final String content;
  final String? firstButtonText;
  final String secondButtonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: AppTextStyles.s17w600sf,
      ),
      content: Text(
        content,
        style: AppTextStyles.s13w400sf,
      ),
      actions: [
        if (firstButtonText != null)
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              firstButtonText!,
              style: AppTextStyles.s17w400sf,
            ),
          ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onPressed,
          child: Text(
            secondButtonText,
            style: AppTextStyles.s17w600sf.copyWith(
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
