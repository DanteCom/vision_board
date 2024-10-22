import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class EmptyVision extends StatelessWidget {
  const EmptyVision({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(Images.empty, fit: BoxFit.cover),
          ),
          const Gap(24),
          Text(
            'Create your first vision',
            style: AppTextStyles.s16w400ws.copyWith(color: AppColors.main),
          )
        ],
      ),
    );
  }
}
