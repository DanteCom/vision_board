import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:vision_board/app/ui/widgets/auxiliary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class DatePage extends StatelessWidget {
  const DatePage({super.key, required this.state});

  final AddState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16),
          child: AuxiliaryText(
            title: 'Select a date',
            subtitle: 'Set a due date for achieving your dream',
          ),
        ),
        SizedBox(
          height: SizerUtil.height / 4,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime dateTime) =>
                state.addDateTime(dateTime),
          ),
        ),
      ],
    );
  }
}
