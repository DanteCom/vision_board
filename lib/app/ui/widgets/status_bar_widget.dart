import 'package:vision_board/app/ui/theme/app_text_styles.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/theme/app_colors.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key, required this.state});

  final AddState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Picture',
                  style: AppTextStyles.s12w400ws.copyWith(
                    color: AppColors.main,
                  ),
                ),
                Text(
                  'Title & Note',
                  style: AppTextStyles.s12w400ws.copyWith(
                    color: state.currentPage > 0
                        ? AppColors.main
                        : AppColors.mainLight,
                  ),
                ),
                Text(
                  'Deadline',
                  style: AppTextStyles.s12w400ws.copyWith(
                    color: state.currentPage > 1
                        ? AppColors.main
                        : AppColors.mainLight,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.main,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(Vectors.picture),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 2,
                      color: state.currentPage > 0
                          ? AppColors.main
                          : AppColors.mainLight,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: state.currentPage > 0
                        ? AppColors.main
                        : AppColors.mainLight,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(Vectors.note),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 2,
                      color: state.currentPage > 1
                          ? AppColors.main
                          : AppColors.mainLight,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: state.currentPage > 1
                        ? AppColors.main
                        : AppColors.mainLight,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(Vectors.calendar),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
