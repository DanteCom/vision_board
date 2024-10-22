import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:gap/gap.dart';

class LimitScreen extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onContinue;
  const LimitScreen({
    super.key,
    required this.onPressed,
    required this.onContinue,
  });

  @override
  State<LimitScreen> createState() => _LimitScreenState();
}

class _LimitScreenState extends State<LimitScreen> {
  final box = Hive.box('settings');
  bool isContinueActive = false;

  void continueActived() {
    isContinueActive = true;
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      isContinueActive = false;
      await box.put('subscription', true);
      widget.onContinue();
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(Images.onboard4),
                Positioned(
                  top: 16,
                  right: 16,
                  child: SafeArea(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: widget.onPressed,
                      child: SvgPicture.asset(Vectors.close),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 38)
                        .copyWith(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(8),
                    Text(
                      'make all your\ndreams a reality'.toUpperCase(),
                      style: AppTextStyles.s32w500ws.copyWith(
                        color: AppColors.black,
                        height: 1.2,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Unlock all app features for just\n\$2.99/week',
                      style: AppTextStyles.s14w400ws,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: AppColors.main,
                        disabledColor: AppColors.main,
                        borderRadius: BorderRadius.circular(100),
                        onPressed:
                            isContinueActive ? null : () => continueActived(),
                        child: isContinueActive
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: AppColors.white,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue'.toUpperCase(),
                                    style: AppTextStyles.s16w500ws,
                                  ),
                                  const Gap(8),
                                  SvgPicture.asset(Vectors.arrowRight),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
