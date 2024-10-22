import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:vision_board/app/ui/widgets/auxiliary_text.dart';
import 'package:vision_board/app/ui/widgets/picture_widget.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({super.key, required this.state});

  final AddState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16),
          child: AuxiliaryText(
            title: 'Upload a picture',
            subtitle: 'A picture should mirror your dream',
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: state.image == null ? () => state.addImage(context) : null,
          child: Container(
            width: double.infinity,
            height: SizerUtil.height / 2 - 50,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: state.image != null
                ? PictureWidget(state: state)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Upload a picture'.toUpperCase(),
                        style: AppTextStyles.s16w500ws
                            .copyWith(color: AppColors.main),
                      ),
                      const Gap(8),
                      const Icon(Icons.add, color: AppColors.main)
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
