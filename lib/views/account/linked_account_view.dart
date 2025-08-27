import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/generated/assets.gen.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_bloc.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_event.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_state.dart';
import 'package:english_mate/views/account/link_email_info_view.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LinkedAccountView extends StatefulWidget {
  const LinkedAccountView({super.key});

  @override
  State<LinkedAccountView> createState() => _LinkedAccountViewState();
}

class _LinkedAccountViewState extends State<LinkedAccountView> {
  void _linkedWithGoogleAccount() {
    context.read<LinkedAccountBloc>().add(LinkedAccountGoogle());
  }

  Future<void> _linkedWithEmailAccount() async {
    final Map<String, String>? data = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero, // bỏ margin hai bên
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width, // gần như full screen
          child: const SingleChildScrollView(child: LinkEmailInfoView()),
        ),
      ),
    );

    if (data == null) return; // user hủy

    context.read<LinkedAccountBloc>().add(
      LinkedAccountEmail(email: data['email']!, password: data['password']!),
    );
  }

  void _unLinkedGoogleAccount() {
    context.read<LinkedAccountBloc>().add(UnLinkedAccountGoogle());
  }

  void _unLinkedEmailAccount() {
    context.read<LinkedAccountBloc>().add(UnLinkedAccountEmail());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LinkedAccountBloc, LinkedAccountState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LinkedAccountStatus.failure) {
          context.pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Lỗi không xác định')),
          );
        } else if (state.status == LinkedAccountStatus.success) {
          context.pop();
        } else if (state.status == LinkedAccountStatus.loading) {
          showLoadingDialog(context: context, content: "Vui lòng chờ ...");
        }
      },
      buildWhen: (previous, current) {
        return previous.status != current.status ||
            previous.appAuthProvider != current.appAuthProvider;
      },
      builder: (context, state) {
        bool isLinkedGoogle = state.appAuthProvider.contains(
          AppAuthProvider.google,
        );
        bool isLinkedEmail = state.appAuthProvider.contains(
          AppAuthProvider.email,
        );
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isLinkedEmail
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: ListTile(
                    onTap: isLinkedEmail
                        ? _unLinkedEmailAccount
                        : _linkedWithEmailAccount,
                    leading: Icon(
                      Icons.mail_outline,
                      size: 32,

                      color: isLinkedEmail
                          ? Theme.of(context).colorScheme.onTertiary
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isLinkedEmail
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: isLinkedEmail
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.onTertiary,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: isLinkedGoogle
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: ListTile(
                    onTap: isLinkedGoogle
                        ? _unLinkedGoogleAccount
                        : _linkedWithGoogleAccount,
                    leading: Assets.images.logo.googleLogo.image(
                      width: 32,
                      color: isLinkedGoogle
                          ? Theme.of(context).colorScheme.onTertiary
                          : null,
                    ),
                    title: Text(
                      "Google",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isLinkedGoogle
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: isLinkedGoogle
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.onTertiary,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
