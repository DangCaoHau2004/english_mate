import 'package:english_mate/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class LinkedAccountView extends StatefulWidget {
  const LinkedAccountView({super.key});

  @override
  State<LinkedAccountView> createState() => _LinkedAccountViewState();
}

class _LinkedAccountViewState extends State<LinkedAccountView> {
  void _linkedWithGoogleAccount() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),

              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.mail_outline, size: 32),
                title: Text(
                  "Email",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "Linked",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),

              child: ListTile(
                onTap: _linkedWithGoogleAccount,
                leading: Assets.images.logo.googleLogo.image(width: 32),
                title: Text(
                  "Google",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "Linked",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
