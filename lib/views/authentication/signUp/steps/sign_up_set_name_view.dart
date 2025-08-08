import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSetNameView extends StatelessWidget {
  const SignUpSetNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Họ và tên:",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.secondary.withAlpha(25),
              ).applyDefaults(Theme.of(context).inputDecorationTheme),

              onChanged: (value) {
                context.read<UserInfoBloc>().add(
                  UserInfoNameChanged(name: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
