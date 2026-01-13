import 'package:clara/my_package.dart';
import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/routes/navigation_routes.dart';
import 'package:test_project/app/features/dashboard/core/utils/app_navigation.dart';
import 'package:test_project/app/features/dashboard/sidebar/sidebar_item.dart';

class Sidebar extends StatelessWidget {
  final bool collapsed;
  const Sidebar({super.key, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const SizedBox(height: 16), ..._items(context)],
    ).wrapInCard();
  }

  List<Widget> _items(BuildContext context) {
    return [
      _item(
        context,
        title: 'Anasayfa',
        icon: Icons.analytics_outlined,
        color: AppColors.primary(context),
        route: RoutesName.dashboard.path,
      ),
      _item(
        context,
        title: 'Paketler',
        icon: Icons.workspace_premium_outlined,
        color: AppColors.warning(context),
        route: RoutesName.packages.path,
      ),
      _item(
        context,
        title: 'Kullanıcılar',
        icon: Icons.group_outlined,
        color: AppColors.success(context),
        route: RoutesName.users.path,
      ),
      _item(
        context,
        title: 'Finans',
        icon: Icons.currency_lira_outlined,
        color: AppColors.info(context),
        route: RoutesName.finance.path,
      ),
      _item(
        context,
        title: 'Ayarlar',
        icon: Icons.settings_outlined,
        color: AppColors.bottomNavUnselected(context),
        route: RoutesName.settings.path,
      ),
    ];
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    final content = SidebarItem(
      title: collapsed ? '' : title,
      icon: icon,
      iconColor: color,
      textColor: color,
      hoverColor: color.withValues(alpha: 0.08),
      onTap: () => AppNav.offAllNamed(route),
    );

    return collapsed
        ? Tooltip(
            message: title,
            waitDuration: const Duration(milliseconds: 300),
            child: content,
          )
        : content;
  }
}
