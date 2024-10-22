import 'package:vision_board/app/ui/screens/add/pages/title_s_note_page.dart';
import 'package:vision_board/app/ui/screens/add/pages/picture_page.dart';
import 'package:vision_board/app/ui/screens/add/pages/date_page.dart';
import 'package:vision_board/app/ui/widgets/status_bar_widget.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/widgets/widgets.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _controller = ScrollController();
  bool isShadow = false;

  @override
  void initState() {
    _controller.addListener(() {
      isShadow = _controller.position.pixels > 10;
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
                              vertical: 8, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => Navigator.pop(context),
                                child: SvgPicture.asset(Vectors.arrowBack),
                              ),
                              Text(
                                'Create vision card',
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ).copyWith(bottom: 100),
                      controller: _controller,
                      children: [
                        StatusBarWidget(state: state),
                        if (state.currentPage == 0) PicturePage(state: state),
                        if (state.currentPage == 1)
                          TitleSNotePage(state: state, read: read),
                        if (state.currentPage == 2) DatePage(state: state),
                      ],
                    ),
                    Positioned(
                      bottom: 16,
                      left: 77,
                      right: 77,
                      child: AppButton(
                        onPressed: state.isPicturePageActive ||
                                state.isTitleSNotePageActive ||
                                state.isDatePageActive
                            ? () => state.onTapContinue(context)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
