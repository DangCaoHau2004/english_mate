import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_bloc.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_event.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_state.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:english_mate/views/authentication/widgets/social_login_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  void _singIn() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<SignInBloc>().add(SignInWithEmailAndPassword());
  }

  @override
  Widget build(BuildContext context) {
    // tắt bàn phím
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,

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
            context.pop();

            if (state.userInfoData == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lỗi không xác định khi đăng ký!'),
                ),
              );
              return;
            }

            UserInfoData userInfoData = state.userInfoData!;
            context.push(RoutePath.userInfo, extra: userInfoData);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chào mừng bạn đã quay trở lại!👋",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Hãy đăng nhập để tiếp tục hành trình cùng chúng tôi.",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              "Email",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              keyboardType: TextInputType.emailAddress,

                              decoration:
                                  InputDecoration(
                                    hintText: "Email ...",
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ).applyDefaults(
                                    Theme.of(context).inputDecorationTheme,
                                  ),
                              style: Theme.of(context).textTheme.bodyMedium,
                              validator: (value) {
                                if (!value!.contains("@")) {
                                  return "Bạn phải nhập đúng định dang email!";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context.read<SignInBloc>().add(
                                  SignInEmailChanged(email: value),
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            Text(
                              "Password",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration:
                                  InputDecoration(
                                    hintText: "Password ...",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                      icon: _hidePassword
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: Theme.of(
                                                context,
                                              ).iconTheme.color,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              color: Theme.of(
                                                context,
                                              ).iconTheme.color,
                                            ),
                                    ),
                                  ).applyDefaults(
                                    Theme.of(context).inputDecorationTheme,
                                  ),
                              onChanged: (value) {
                                context.read<SignInBloc>().add(
                                  SignInPasswordChanged(password: value),
                                );
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Bạn cần điền mật khẩu!";
                                }
                                if (value.length < 6) {
                                  return "Mật khẩu cần tối thiểu 6 kí tự!";
                                }
                                return null;
                              },
                              obscureText: _hidePassword,
                            ),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: Theme.of(context)
                                      .textButtonTheme
                                      .style!
                                      .copyWith(
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                              Theme.of(
                                                context,
                                              ).colorScheme.tertiary,
                                            ),
                                      ),
                                  onPressed: () {},
                                  child: const Text("Quên mật khẩu"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    const TextSpan(
                                      text: "Bạn chưa có tài khoản?",
                                    ),
                                    TextSpan(
                                      text: " Đăng kí",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          FocusScope.of(context).unfocus();
                                          context.replace(RoutePath.signUp);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            Row(
                              children: <Widget>[
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "Hoặc đăng nhập bằng",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ),
                                  ),
                                ),
                                const Expanded(child: Divider(thickness: 1)),
                              ],
                            ),

                            const SizedBox(height: 32),

                            const SocialLoginButton(),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),

                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _singIn,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Đăng nhập"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
