import 'package:clara/my_package.dart';
import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  final Color? iconColor;
  final Color? textColor;
  final Color? hoverColor;
  final Color? backgroundColor;

  const SidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.hoverColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: context.normalBorderRadius),
      hoverColor: hoverColor ?? Colors.grey.withValues(alpha: 0.08),
      tileColor: backgroundColor,
      leading: _buildIcon(),
      title: _buildTitle(context),
      onTap: onTap,
    ).wrapInCard();
  }

  Widget _buildIcon() {
    return Icon(
      icon,
      color: iconColor ?? Colors.grey.shade700,
      fontWeight: FontWeight.w300,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: context.textStyles.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: textColor ?? Colors.grey.shade800,
      ),
    );
  }
}
