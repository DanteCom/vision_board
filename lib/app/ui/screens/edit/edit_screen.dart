import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/app/ui/widgets/picture_widget.dart';
import 'package:vision_board/app/ui/widgets/title_textfiled.dart';
import 'package:vision_board/app/ui/widgets/auxiliary_text.dart';
import 'package:vision_board/app/ui/widgets/note_textfiled.dart';
import 'package:vision_board/app/ui/widgets/app_button.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _controller = ScrollController();
  final _box = Hive.box('settings');
  late bool subscribed;
  bool isShadow = false;

  @override
  void initState() {
    isSubscribed();
    _controller.addListener(() {
      isShadow = _controller.position.pixels > 10;
      setState(() {});
    });
    _box.listenable().addListener(isSubscribed);
    super.initState();
  }

  void isSubscribed() {
    subscribed = _box.get('subscription', defaultValue: false);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _box.listenable().removeListener(isSubscribed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddState>();
    final read = context.read<AddState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 4),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => Navigator.pop(context),
                                child: SvgPicture.asset(Vectors.arrowBack),
                              ),
                              Text(
                                'Edit vision card',
                                style: AppTextStyles.s20w400ws,
                              ),
                              const Gap(44),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      controller: _controller,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ).copyWith(bottom: 88),
                      children: [
                        const AuxiliaryText(
                          title: 'Replace a picture',
                          subtitle: 'A picture should mirror your dream',
                        ),
                        const Gap(16),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: state.image == null
                              ? () => state.addImage(context)
                              : null,
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
                                      const Icon(Icons.add,
                                          color: AppColors.main)
                                    ],
                                  ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32, bottom: 16),
                          child: AuxiliaryText(
                            title: 'Change the name',
                            subtitle: 'Come up with a name for your vision',
                          ),
                        ),
                        TitleTextFiled(
                          controller: state.titleController,
                          onChanged: (_) => read.setState(),
                          bottomScrollPadding: 300,
                          topScrollPadding: 150,
                        ),
                        const Gap(32),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: subscribed
                              ? null
                              : () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              LimitScreen(
                                        onPressed: () => Navigator.pop(context),
                                        onContinue: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: AuxiliaryText(
                                  icon: subscribed ? null : Vectors.crown,
                                  title: 'Rewrite the note',
                                  subtitle: 'You can change your note',
                                ),
                              ),
                              Stack(
                                children: [
                                  NoteTextFiled(
                                    controller: state.noteController,
                                    onChanged: (_) => read.setState(),
                                    topScrollPadding: 130,
                                    enabled: subscribed ? null : false,
                                  ),
                                  Positioned(
                                    right: 16,
                                    bottom: 16,
                                    child: Text(
                                      '${state.noteController.text.length}/300',
                                      style: AppTextStyles.s12w400ws.copyWith(
                                        color: AppColors.black40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32, bottom: 16),
                          child: AuxiliaryText(
                            title: 'Change the date',
                            subtitle: 'Set a due date for achieving your dream',
                          ),
                        ),
                        SizedBox(
                          height: SizerUtil.height / 4,
                          child: CupertinoDatePicker(
                              initialDateTime: state.dateTime,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime dateTime) {
                                state.addDateTime(dateTime);
                              }),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 16,
                      left: 77,
                      right: 77,
                      child: AppButton(
                        onPressed: state.saveActive
                            ? () => state.editVision(context, state.vision!.id)
                            : null,
                        text: 'Save',
                        icon: Vectors.check,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
