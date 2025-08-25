import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_event.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_state.dart';
import 'package:english_mate/widgets/custom_picker_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSetStudyTimeView extends StatefulWidget {
  const SignUpSetStudyTimeView({super.key});

  @override
  State<SignUpSetStudyTimeView> createState() => _SignUpSetStudyTimeViewState();
}

class _SignUpSetStudyTimeViewState extends State<SignUpSetStudyTimeView> {
  final hours = List.generate(24, (i) => i);
  final minutes = List.generate(60, (i) => i);

  final double height = 300;
  final double width = 100;
  final double itemExtent = 40;

  @override
  Widget build(BuildContext context) {
    if (context.read<UserInfoBloc>().state.studyTime == null) {
      context.read<UserInfoBloc>().add(
        UserInfoStudyTimeChanged(
          studyTime: (const TimeOfDay(hour: 20, minute: 0)),
        ),
      );
    }
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        TimeOfDay scheduleTime =
            state.studyTime ?? const TimeOfDay(hour: 20, minute: 0);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Hẹn giờ thời gian học của bạn',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPickerWheel(
                          height: height,
                          list: hours,
                          onChanged: (value) {
                            context.read<UserInfoBloc>().add(
                              UserInfoStudyTimeChanged(
                                studyTime: TimeOfDay(
                                  hour: value,
                                  minute: scheduleTime.minute,
                                ),
                              ),
                            );
                          },
                          selectedIndex: scheduleTime.hour,
                          width: width,
                          itemExtent: itemExtent,
                          indexInitial: scheduleTime.hour,
                        ),
                        Text(
                          ":",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                        ),
                        CustomPickerWheel(
                          height: height,
                          list: minutes,
                          onChanged: (value) {
                            context.read<UserInfoBloc>().add(
                              UserInfoStudyTimeChanged(
                                studyTime: TimeOfDay(
                                  hour: scheduleTime.hour,
                                  minute: value,
                                ),
                              ),
                            );
                          },
                          selectedIndex: scheduleTime.minute,
                          width: width,
                          itemExtent: itemExtent,
                          indexInitial: scheduleTime.minute,
                        ),
                      ],
                    ),
                    IgnorePointer(
                      child: Container(
                        height: itemExtent,
                        width: width * 2,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                Text(
                  'Bạn có thể thiết lập sau trong cài đặt',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                TextButton(
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                    foregroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  onPressed: () {
                    context.read<UserInfoBloc>().add(
                      UserInfoStudyTimeSkipped(),
                    );
                    //submit lên db
                    context.read<UserInfoBloc>().add(UserInfoSubmitted());
                  },
                  child: const Text('Bỏ qua'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
