import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_bloc.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_event.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_state.dart';
import 'package:english_mate/views/authentication/widgets/social_login_buttons.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _agreeCondition = false;

  void _signUp() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_agreeCondition) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bạn phải đồng ý với điều khoản và điều kiện"),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    context.read<SignUpBloc>().add(SignUpSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignUpBloc, SignUpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SignUpStatus.loading) {
            showLoadingDialog(context: context, content: "Đang đăng ký ...");
          } else if (state.status == SignUpStatus.failure) {
            context.pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Lỗi không xác định'),
              ),
            );
          }
          // nếu thành công
          else if (state.status == SignUpStatus.success) {
            context.pop();
            context.push(RoutePath.userInfo);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16), // Padding top
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chào mừng bạn đến với English Mate!✨",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Hãy tạo tài khoản để bắt đầu hành trình tuyệt vời của mình nhé.",
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
                                          color: Theme.of(
                                            context,
                                          ).iconTheme.color,
                                        ),
                                      ).applyDefaults(
                                        Theme.of(context).inputDecorationTheme,
                                      ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  validator: (value) {
                                    if (value == null || !value.contains("@")) {
                                      return "Bạn phải nhập đúng định dạng email!";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    context.read<SignUpBloc>().add(
                                      SignUpEmailChanged(email: value),
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
                                          color: Theme.of(
                                            context,
                                          ).iconTheme.color,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _hidePassword = !_hidePassword;
                                            });
                                          },
                                          child: _hidePassword
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
                                    context.read<SignUpBloc>().add(
                                      SignUpPasswordChanged(password: value),
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
                                  children: [
                                    Checkbox(
                                      value: _agreeCondition,
                                      onChanged: (value) {
                                        setState(() {
                                          _agreeCondition = value!;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                          children: [
                                            const TextSpan(
                                              text: "Tôi đồng ý với",
                                            ),
                                            TextSpan(
                                              text: " Điều khoản và Điều kiện",
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
                                                  // TODO: Navigate to Terms and Conditions page
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      children: [
                                        const TextSpan(
                                          text: "Bạn đã có tài khoản?",
                                        ),
                                        TextSpan(
                                          text: " Đăng nhập",
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
                                              context.replace(RoutePath.signIn);
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                  style: Theme.of(context).textTheme.bodyMedium!
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

                      // Button Đăng kí sẽ được đẩy xuống cuối cùng
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signUp,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Đăng kí"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
