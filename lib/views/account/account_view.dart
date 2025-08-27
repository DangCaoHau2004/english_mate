import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  void _goToEditProfile() {
    context.push(RoutePath.editProfile);
  }

  void _goToSetting() {
    context.push(RoutePath.setting);
  }

  void _goToLinkAccount() {
    context.push(RoutePath.linkedAccount);
  }

  void _goToHelpAndSupport() {}
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    UserData userData = context.read<AuthGateCubit>().state.userData!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: ListTile(
              onTap: _goToEditProfile,
              leading: Icon(
                Icons.person,
                size: 32,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              title: Text(
                userData.fullName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
              subtitle: Text(
                userData.email,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
          const SizedBox(height: 32),

          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.secondary.withAlpha(10),
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: _goToSetting,
                  leading: const Icon(Icons.settings),
                  title: Text(
                    "Cài đặt",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: _goToLinkAccount,
                  leading: const Icon(Icons.sync_alt),
                  title: Text(
                    "Tài khoản liên kết",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios),
                ),

                ListTile(
                  onTap: _goToHelpAndSupport,
                  leading: const Icon(Icons.support_agent),
                  title: Text(
                    "Trợ giúp và hỗ trợ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          TextButton(
            onPressed: _signOut,
            child: Text(
              "Đăng xuất",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
