import 'package:vision_board/app/ui/widgets/app_cupertino_alert_dialog.dart';
import 'package:vision_board/app/ui/screens/edit/edit_screen.dart';
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

class CustomModalBottomSheet extends StatefulWidget {
  final Vision vision;
  const CustomModalBottomSheet({
    super.key,
    required this.vision,
  });

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  final _controller = ScrollController();
  bool isShadow = false;
  late bool isFulfilled;
  void changeFulfilled() async {
    isFulfilled = !isFulfilled;
    widget.vision.isGoalFulfilled(isFulfilled);
    setState(() {});
  }

  @override
  void initState() {
    isFulfilled = widget.vision.isFulfilled;
    _controller.addListener(() {
      isShadow = _controller.position.pixels > 5;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');
    final state = context.watch<AddState>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 48.0,
          height: 4.0,
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFBABABA),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Container(
          width: double.infinity,
          height: SizerUtil.height - 145,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                  top: 16,
                ),
                duration: kThemeAnimationDuration,
                decoration: BoxDecoration(
                  boxShadow: [if (isShadow) AppTheme.containerShadow],
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: SizerUtil.height / 2,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: SizerUtil.height / 2 - 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.memory(
                              widget.vision.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 37,
                            right: 37,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CupertinoButton(
                                      color: AppColors.main,
                                      padding: const EdgeInsets.all(8),
                                      borderRadius: BorderRadius.circular(100),
                                      child: SvgPicture.asset(Vectors.pen),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ChangeNotifierProvider(
                                                create: (context) => AddState(
                                                  vision: widget.vision,
                                                ),
                                                child: const EditScreen(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const Gap(8),
                                    CupertinoButton(
                                      color: AppColors.main,
                                      padding: const EdgeInsets.all(8),
                                      borderRadius: BorderRadius.circular(100),
                                      child: SvgPicture.asset(Vectors.trash),
                                      onPressed: () => showCupertinoDialog(
                                        context: context,
                                        builder: (context) =>
                                            AppCupertinoAlertDioalg(
                                          title: 'Delete vision?',
                                          content:
                                              'Vision will be deleted, do you really\nwant to continue?',
                                          firstButtonText: 'Cancel',
                                          secondButtonText: 'Delete',
                                          onPressed: () => state.deleteVision(
                                            context,
                                            widget.vision.id,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainLight,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Up to:',
                                        style: AppTextStyles.s16w400ws,
                                      ),
                                      const Gap(4),
                                      Text(
                                        formatter.format(widget.vision.date),
                                        style: AppTextStyles.s20w400ws,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      child: Text(
                        widget.vision.title,
                        style: AppTextStyles.s22w600ws,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      controller: _controller,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ).copyWith(bottom: 100),
                      children: [
                        Text(
                          widget.vision.note ?? '',
                          style: AppTextStyles.s14w400ws,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 16,
                      left: 77,
                      right: 77,
                      child: CupertinoButton(
                        onPressed: () => changeFulfilled(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: isFulfilled ? 16 : 18.5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.main,
                            ),
                            color:
                                isFulfilled ? AppColors.white : AppColors.main,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'goal fulfilled'.toUpperCase(),
                                style: AppTextStyles.s16w500ws.copyWith(
                                  color: isFulfilled
                                      ? AppColors.main
                                      : AppColors.white,
                                ),
                              ),
                              if (isFulfilled)
                                Row(
                                  children: [
                                    const Gap(8),
                                    SvgPicture.asset(
                                      Vectors.checkCircle,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
