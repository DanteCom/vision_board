import 'package:vision_board/app/ui/screens/limit/limit_screen.dart';
import 'package:vision_board/app/ui/widgets/title_textfiled.dart';
import 'package:vision_board/app/ui/widgets/note_textfiled.dart';
import 'package:vision_board/app/ui/widgets/auxiliary_text.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/resources/resources.dart';
import 'package:vision_board/app/ui/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class TitleSNotePage extends StatefulWidget {
  const TitleSNotePage({super.key, required this.state, required this.read});
  final AddState state;
  final AddState read;
  @override
  State<TitleSNotePage> createState() => _TitleSNotePageState();
}

class _TitleSNotePageState extends State<TitleSNotePage> {
  final _box = Hive.box('settings');
  late bool subscribed;
  @override
  void initState() {
    isSubscribed();
    _box.listenable().addListener(isSubscribed);
    super.initState();
  }

  void isSubscribed() {
    subscribed = _box.get('subscription', defaultValue: false);
    setState(() {});
  }

  @override
  void dispose() {
    _box.listenable().removeListener(isSubscribed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16),
          child: AuxiliaryText(
            title: 'Type in the name',
            subtitle: 'Come up with a name for your vision',
          ),
        ),
        TitleTextFiled(
          controller: widget.state.titleController,
          onChanged: (_) => widget.read.setState(),
        ),
        const Gap(32),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: subscribed
              ? null
              : () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          LimitScreen(
                        onPressed: () => Navigator.pop(context),
                        onContinue: () => Navigator.pop(context),
                      ),
                    ),
                  );
                },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AuxiliaryText(
                  icon: subscribed ? null : Vectors.crown,
                  title: 'Write a note',
                  subtitle: 'You can add details about your goal',
                ),
              ),
              Stack(
                children: [
                  NoteTextFiled(
                    controller: widget.state.noteController,
                    onChanged: (_) => widget.read.setState(),
                    enabled: subscribed ? null : false,
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Text(
                      '${widget.state.noteController.text.length}/300',
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
      ],
    );
  }
}
