import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/widgets/sidebar/sidebar_header.dart';
import 'package:test_project/core/widgets/sidebar_item.dart';

/// Yan menü widgetı
///
/// Navigasyon menüsünü ve başlığını içerir
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _SidebarTheme.backgroundColor,
      child: Column(children: [const SidebarHeader(), ..._buildMenuItems()]),
    );
  }

  /// Menü öğelerini oluşturur
  List<Widget> _buildMenuItems() {
    return [
      SidebarItem(
        title: 'Dashboard',
        icon: Icons.dashboard,
        route: '/dashboard',
        onTap: () => Get.offAllNamed('/dashboard'),
      ),
    ];
  }
}

/// Sidebar tema sabitleri
class _SidebarTheme {
  static final Color backgroundColor = Colors.grey.shade900;
}
