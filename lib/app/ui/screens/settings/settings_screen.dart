import 'package:vision_board/app/ui/widgets/app_cupertino_alert_dialog.dart';
import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = ScrollController();
  final _box = Hive.box('settings');
  bool isShadow = false;
  late bool subscribed;
  @override
  void initState() {
    isSubscribed();
    _box.listenable().addListener(isSubscribed);
    _controller.addListener(() {
      isShadow = _controller.position.pixels > 10;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _box.listenable().removeListener(isSubscribed);
    _controller.dispose();
    super.dispose();
  }

  void isSubscribed() {
    subscribed = _box.get('subscription', defaultValue: false);
    setState(() {});
  }

  void tapOnSubscribed() {
    Navigator.pop(context);
    Navigator.pop(context);
    showCupertinoDialog(
      context: context,
      builder: (context) => AppCupertinoAlertDioalg(
        title: 'Enjoying the app?',
        content: 'We value your feedback to keep improving the app',
        firstButtonText: 'No',
        secondButtonText: 'Yes',
        onPressed: () async {
          showCupertinoDialog(
            context: context,
            builder: (context) => AppCupertinoAlertDioalg(
              title: 'Please leave a review!',
              content:
                  'Your subscription is now active! Now\nyou have access to all app features',
              firstButtonText: null,
              secondButtonText: 'Go to the AppStore',
              onPressed: () async {
                final inAppReview = InAppReview.instance;
                final isAvailable = await inAppReview.isAvailable();
                if (isAvailable) inAppReview.requestReview();
                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                .copyWith(bottom: 4),
            decoration: BoxDecoration(
              boxShadow: [if (isShadow) AppTheme.containerShadow],
              color: AppColors.white,
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: SvgPicture.asset(Vectors.arrowBack),
                    ),
                    Text('Settings', style: AppTextStyles.s20w400ws),
                    const Gap(44),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _controller,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                if (!subscribed)
                  Column(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LimitScreen(
                              onPressed: () => Navigator.pop(context),
                              onContinue: () => tapOnSubscribed(),
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 31),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.main,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(Vectors.crown),
                              const Gap(8),
                              Text(
                                'Unlock all features',
                                style: AppTextStyles.s22w400ws.copyWith(
                                  color: AppColors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Gap(24),
                    ],
                  ),
                SettingsButton(onPressed: () {}, text: 'Terms of Use'),
                const Gap(12),
                SettingsButton(onPressed: () {}, text: 'Privacy Policy'),
                const Gap(12),
                SettingsButton(
                  text: 'Share app',
                  onPressed: () {
                    String shareUrl = Platform.isIOS
                        ? 'https://apps.apple.com/'
                        : 'https://play.google.com/store/apps';
                    Share.share(shareUrl);
                  },
                ),
                const Gap(12),
                SettingsButton(onPressed: () {}, text: 'Support'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.main),
        ),
        child: Text(
          text,
          style: AppTextStyles.s16w500ws.copyWith(
            color: AppColors.main,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
