import 'package:vision_board/app/domain/states/home_state.dart';
import 'package:vision_board/app/ui/widgets/custom_modal_bottom_sheet.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/domain/models/vision.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class VisionCard extends StatelessWidget {
  const VisionCard({super.key, required this.vision, required this.index});
  final Vision vision;
  final int index;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy');
    return SizedBox(
      width: SizerUtil.width / 3 - 16,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AddState()),
              ChangeNotifierProvider(create: (context) => HomeState())
            ],
            child: CustomModalBottomSheet(vision: vision, index: index),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(
                vision.isFulfilled ? 3 : 0,
              ),
              decoration: const BoxDecoration(
                color: AppColors.main,
                shape: BoxShape.circle,
              ),
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Image.memory(
                      vision.image,
                      fit: BoxFit.cover,
                    ),
                    if (vision.isFulfilled)
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: SvgPicture.asset(
                            Vectors.checkMark,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const Gap(8),
            Text(
              formatter.format(vision.dateTime),
              style: AppTextStyles.s12w400ws,
            ),
            const Gap(4),
            Text(
              vision.title,
              style: AppTextStyles.s14w400ws.copyWith(
                color: AppColors.black90,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
