import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_event.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_state.dart';
import 'package:english_mate/widgets/account_connection_card.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:english_mate/generated/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GettingStartedView extends StatelessWidget {
  const GettingStartedView({super.key});

  // link chân trang
  Widget legalLinkFooter(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style!.copyWith(
        foregroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.secondary,
        ),
      ),

      onPressed: onPressed,
      child: Text(text),
    );
  }

  // đăng nhập bằng google
  void _signInWithGoogle(BuildContext context) {
    context.read<SignInBloc>().add(SignInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status == SignInStatus.loading) {
            showLoadingDialog(context: context, content: "Đang đăng nhập ...");
          } else if (state.status == SignInStatus.success) {
            // bỏ loading dialog
            context.pop();
          } else if (state.status == SignInStatus.failure) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Lỗi không xác định'),
              ),
            );
          } else if (state.status == SignInStatus.profileRequired) {
            //bỏ dialog
            context.pop();
            context.push(RoutePath.userInfo);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Assets.images.logo.logo.image(width: 160),
              Text(
                "Nơi những ý tưởng lớn gặp nhau.",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "Hãy tạo tài khoản để cùng chia sẻ và phát triển.",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              AccountConnectionCard(
                logoAsset: Assets.images.logo.googleLogo.image(width: 32),
                title: "Tiếp tục với Google",
                isCenter: true,
                onPressed: () {
                  _signInWithGoogle(context);
                },
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    context.push(RoutePath.signUp);
                  },
                  child: const Text("Đăng kí"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    context.push(RoutePath.signIn);
                  },
                  child: const Text("Đăng nhập"),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  legalLinkFooter(context, "Privacy Policy", () {}),
                  legalLinkFooter(context, "Terms of Use", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
