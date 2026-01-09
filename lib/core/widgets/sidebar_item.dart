import 'package:flutter/material.dart';

/// Sidebar menü öğesi
///
/// Tek bir navigasyon öğesini temsil eder
class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: _buildIcon(), title: _buildTitle(), onTap: onTap);
  }

  Widget _buildIcon() {
    return Icon(icon, color: _ItemTheme.iconColor);
  }

  Widget _buildTitle() {
    return Text(title, style: _ItemTheme.titleStyle);
  }
}

/// Sidebar öğesi tema sabitleri
class _ItemTheme {
  static const Color iconColor = Colors.white;

  static const TextStyle titleStyle = TextStyle(color: Colors.white);
}
