import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/app/ui/screens/home/home_screen.dart';
import 'package:vision_board/app/ui/theme/app_text_styles.dart';
import 'package:vision_board/app/domain/models/onboard.dart';
import 'package:vision_board/app/ui/theme/app_colors.dart';
import 'package:vision_board/app/ui/widgets/widgets.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:gap/gap.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final box = Hive.box('settings');
  final _inAppReview = InAppReview.instance;
  final onboardList = Onboard.onboardList;
  int currentPage = 0;

  void changePage(BuildContext context) async {
    final isAvailable = await _inAppReview.isAvailable();
    final subscribed = await box.get('subscribed', defaultValue: false);
    if (currentPage == 1 && isAvailable) {
      _inAppReview.requestReview();
    }
    if (onboardList.length - 1 == currentPage) {
      await box.put('onboard', true);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => subscribed
                ? const HomeScreen()
                : LimitScreen(
                    onContinue: () {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const HomeScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      }
                    },
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const HomeScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    ),
                  ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      }
      return;
    }
    currentPage++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final onboard = onboardList[currentPage];
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Image.asset(
              onboard.image,
              fit: BoxFit.cover,
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
                      onboard.title.toUpperCase(),
                      style: AppTextStyles.s32w500ws.copyWith(
                        color: AppColors.black,
                        height: 1.2,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      onboard.subtitle,
                      style: AppTextStyles.s14w400ws,
                    ),
                    const Spacer(),
                    AppButton(onPressed: () => changePage(context)),
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
