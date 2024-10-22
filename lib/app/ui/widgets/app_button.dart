import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
  });
  final String? text;
  final String? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.main,
      disabledColor: AppColors.mainLight,
      borderRadius: BorderRadius.circular(100),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (text ?? 'Continue').toUpperCase(),
            style: AppTextStyles.s16w500ws,
          ),
          const Gap(8),
          SvgPicture.asset(icon ?? Vectors.arrowRight),
        ],
      ),
    );
  }
}
