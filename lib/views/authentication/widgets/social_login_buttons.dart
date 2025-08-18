import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_event.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_state.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:english_mate/generated/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SocialLoginButton extends StatefulWidget {
  const SocialLoginButton({super.key});

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == SignInStatus.loading) {
          showLoadingDialog(context: context, content: "Đang đăng nhập ...");
        } else if (state.status == SignInStatus.success) {
          // bỏ loading dialog
          context.pop();
        } else if (state.status == SignInStatus.failure) {
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Lỗi không xác định')),
          );
        } else if (state.status == SignInStatus.profileRequired) {
          context.pop();
          context.push(RoutePath.userInfo);
        }
      },
      child: Center(
        child: IconButton.outlined(
          style: Theme.of(context).iconButtonTheme.style!.copyWith(
            side: WidgetStateProperty.all(
              BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 0.2,
              ),
            ),
          ),
          onPressed: () {
            context.read<SignInBloc>().add(SignInWithGoogle());
          },
          icon: Assets.images.logo.googleLogo.image(width: 32),
        ),
      ),
    );
  }
}
