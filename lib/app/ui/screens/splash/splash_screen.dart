import 'package:vision_board/app/ui/screens/onboard/onboard_screen.dart';
import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/app/ui/screens/home/home_screen.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = Hive.box('settings');

  @override
  void initState() {
    goToPage();
    super.initState();
  }

  void goToPage() async {
    final onboardShown = await box.get('onboard', defaultValue: false);
    final subscribed = await box.get('subscription', defaultValue: false);

    Future.delayed(const Duration(seconds: 1)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => onboardShown
              ? subscribed
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
                    )
              : const OnboardScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              Images.splash,
              width: SizerUtil.height * .28,
            ),
          ],
        ),
      ),
    );
  }
}
