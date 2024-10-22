import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/theme/app_text_styles.dart';
import 'package:vision_board/app/ui/theme/app_colors.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({super.key, required this.state});

  final AddState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.memory(
          state.image!,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          left: 51,
          right: 51,
          child: Center(
            child: CupertinoButton(
              color: AppColors.mainLight,
              borderRadius: BorderRadius.circular(100),
              padding: const EdgeInsets.symmetric(vertical: 8),
              onPressed: () => state.addImage(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'replace a picture'.toUpperCase(),
                    style: AppTextStyles.s16w500ws.copyWith(
                      color: AppColors.main,
                    ),
                  ),
                  const Gap(8),
                  SvgPicture.asset(Vectors.refresh),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
