import 'dart:math';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_event.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:english_mate/widgets/custom_picker_wheel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSetDateOfBirthView extends StatelessWidget {
  const SignUpSetDateOfBirthView({super.key});

  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  int _daysInMonth(int month, int year) {
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) return 31;
    if ([4, 6, 9, 11].contains(month)) return 30;
    return _isLeapYear(year) ? 29 : 28;
  }

  @override
  Widget build(BuildContext context) {
    const double height = 300;
    const double width = 100;
    const double itemExtent = 40;

    return BlocBuilder<UserInfoBloc, UserInfoState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        final selectedDate = state.dateOfBirth ?? DateTime.now();

        final now = DateTime.now();
        final years = List.generate(101, (i) => now.year - 100 + i);
        final months = List.generate(12, (i) => i + 1);
        final days = List.generate(
          _daysInMonth(selectedDate.month, selectedDate.year),
          (i) => i + 1,
        );

        final indexYear = years.indexOf(selectedDate.year);
        final indexMonth = months.indexOf(selectedDate.month);
        final indexDay = days.indexOf(selectedDate.day);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Chọn ngày sinh của bạn',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ngày
                        CustomPickerWheel(
                          list: days,
                          selectedIndex: indexDay,
                          indexInitial: indexDay,
                          onChanged: (index) {
                            final newDate = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              days[index],
                            );
                            context.read<UserInfoBloc>().add(
                              UserInfoDateOfBirthChanged(dateOfBirth: newDate),
                            );
                          },
                          height: height,
                          width: width,
                          itemExtent: itemExtent,
                        ),
                        // tháng
                        CustomPickerWheel(
                          list: months,
                          selectedIndex: indexMonth,
                          indexInitial: indexMonth,
                          onChanged: (index) {
                            final newMonth = months[index];
                            final maxDays = _daysInMonth(
                              newMonth,
                              selectedDate.year,
                            );
                            final newDay = min(selectedDate.day, maxDays);
                            final newDate = DateTime(
                              selectedDate.year,
                              newMonth,
                              newDay,
                            );
                            context.read<UserInfoBloc>().add(
                              UserInfoDateOfBirthChanged(dateOfBirth: newDate),
                            );
                          },
                          height: height,
                          width: width,
                          itemExtent: itemExtent,
                        ),

                        // năm
                        CustomPickerWheel(
                          list: years,
                          selectedIndex: indexYear,
                          indexInitial: indexYear,
                          onChanged: (index) {
                            final newYear = years[index];
                            final maxDays = _daysInMonth(
                              selectedDate.month,
                              newYear,
                            );
                            final newDay = min(selectedDate.day, maxDays);
                            final newDate = DateTime(
                              newYear,
                              selectedDate.month,
                              newDay,
                            );
                            context.read<UserInfoBloc>().add(
                              UserInfoDateOfBirthChanged(dateOfBirth: newDate),
                            );
                          },
                          height: height,
                          width: width,
                          itemExtent: itemExtent,
                        ),
                      ],
                    ),
                    // dòng kẻ đánh dấu ngày tháng năm hiện tại
                    IgnorePointer(
                      child: Container(
                        height: itemExtent,
                        width: width * 3,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
