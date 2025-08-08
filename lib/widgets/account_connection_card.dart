import 'package:flutter/material.dart';

class AccountConnectionCard extends StatelessWidget {
  final Image logoAsset;
  final String title;
  final String? subtitle;
  final Widget? trailingWidget; // Cho phép tùy chỉnh widget ở cuối
  final VoidCallback? onPressed;
  final bool isCenter;

  const AccountConnectionCard({
    super.key,
    required this.logoAsset,
    required this.title,
    this.subtitle,
    this.trailingWidget,
    this.onPressed,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: ListTile(
          leading: logoAsset,
          title: isCenter ? Center(child: Text(title)) : Text(title),
          titleTextStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          subtitle: subtitle != null
              ? Text(subtitle!, style: Theme.of(context).textTheme.bodySmall)
              : null,
          trailing: trailingWidget, // Sử dụng widget được truyền vào
        ),
      ),
    );
  }
}
