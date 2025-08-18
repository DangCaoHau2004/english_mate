import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: const Text("Đăng xuất"),
      ),
    );
  }
}
