import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AuxiliaryText extends StatelessWidget {
  const AuxiliaryText({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });
  final String title;
  final String subtitle;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.s22w400ws.copyWith(
                  color: AppColors.black90,
                ),
              ),
              if (icon != null) const Gap(8),
              // ignore: deprecated_member_use
              if (icon != null) SvgPicture.asset(icon!, color: AppColors.main)
            ],
          ),
          const Gap(8),
          Text(
            subtitle,
            style: AppTextStyles.s14w400ws,
          ),
        ],
      ),
    );
  }
}
