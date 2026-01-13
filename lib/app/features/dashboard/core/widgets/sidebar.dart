import 'package:clara/my_package.dart';
import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/routes/navigation_routes.dart';
import 'package:test_project/app/features/dashboard/core/utils/app_navigation.dart';
import 'package:test_project/app/features/dashboard/core/widgets/sidebar_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [..._buildMenuItems(context)]).wrapInCard();
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    return [
      SidebarItem(
        title: 'Anasayfa',
        icon: Icons.analytics_outlined,
        iconColor: AppColors.primary(context),
        textColor: AppColors.primary(context),
        hoverColor: AppColors.primary(context).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.dashboard.path),
      ),
      SidebarItem(
        title: 'Paketler',
        icon: Icons.workspace_premium_outlined,
        iconColor: AppColors.warning(context),
        hoverColor: AppColors.warning(context).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.packages.path),
      ),
      SidebarItem(
        title: 'Kullanıcılar',
        icon: Icons.group_outlined,
        iconColor: AppColors.success(context),
        hoverColor: AppColors.success(context).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.users.path),
      ),
      SidebarItem(
        title: 'Finans',
        icon: Icons.currency_lira_outlined,
        iconColor: AppColors.info(context),
        hoverColor: AppColors.info(context).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.finance.path),
      ),
      SidebarItem(
        title: 'Sipariş ve Fatura',
        icon: Icons.picture_as_pdf_outlined,
        iconColor: AppColors.error(context),
        hoverColor: AppColors.error(context).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.settings.path),
      ),
      SidebarItem(
        title: 'Ayarlar',
        icon: Icons.settings_outlined,
        // iconColor: AppColors.bottomNavUnselected(context),
        hoverColor: AppColors.bottomNavUnselected(
          context,
        ).withValues(alpha: 0.08),
        onTap: () => AppNav.offAllNamed(RoutesName.settings.path),
      ),
    ];
  }
}
