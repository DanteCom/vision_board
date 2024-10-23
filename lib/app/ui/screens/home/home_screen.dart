import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/app/ui/screens/home/empty_vision.dart';
import 'package:vision_board/app/domain/states/home_state.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/widgets/vision_card.dart';
import 'package:vision_board/app/ui/widgets/widgets.dart';
import 'package:vision_board/app/ui/routes/routes.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _box = Hive.box('settings');
  final _controller = ScrollController();
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

  void isSubscribed() {
    subscribed = _box.get('subscription', defaultValue: false);
    setState(() {});
  }

  @override
  void dispose() {
    _box.listenable().removeListener(isSubscribed);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeState>();
    final visions = state.visionsList;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            AnimatedContainer(
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                boxShadow: [if (isShadow) AppTheme.containerShadow],
                color: AppColors.white,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Gap(44),
                            Text('Vision Board',
                                style: AppTextStyles.s32w500ws),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.settings);
                              },
                              child: SvgPicture.asset(Vectors.settings),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'All your desires in one place',
                        style: AppTextStyles.s16w400ws,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  state.visionsList.isNotEmpty
                      ? ListView(
                          controller: _controller,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ).copyWith(bottom: 100),
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 12,
                              children: [
                                ...List.generate(
                                  visions.length,
                                  (index) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                        create: (context) => AddState(),
                                      ),
                                      ChangeNotifierProvider(
                                        create: (context) => HomeState(),
                                      )
                                    ],
                                    child: VisionCard(
                                      vision: visions[index],
                                      index: index,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const EmptyVision(),
                  Positioned(
                    bottom: 16,
                    left: 77,
                    right: 77,
                    child: AppButton(
                      onPressed: !subscribed && state.visionsList.length >= 3
                          ? () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          LimitScreen(
                                    onPressed: () => Navigator.pop(context),
                                    onContinue: () => Navigator.pop(context),
                                  ),
                                ),
                              );
                            }
                          : () {
                              Navigator.pushNamed(context, RoutesName.add);
                            },
                      text: 'Add new vision',
                      icon: !subscribed && state.visionsList.length >= 3
                          ? Vectors.crown
                          : Vectors.add,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
