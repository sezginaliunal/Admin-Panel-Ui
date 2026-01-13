// lib/app/features/users/widgets/users_header.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/users/users_controller.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/responsive.dart';

class UsersHeader extends GetView<UsersController> {
  const UsersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kullanıcılar', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(
          'Toplam ${controller.totalUsers} kullanıcı',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),

        // Stats Cards - Responsive
        Obx(() {
          final isMobile = Responsive.isMobile(context);
          final isTablet = Responsive.isTablet(context);

          // Mobile: Dikey düzen
          if (isMobile) {
            return Column(
              children: [
                _StatCard(
                  title: 'Toplam',
                  value: controller.totalUsers.toString(),
                  color: AppColors.info(context),
                  icon: Icons.people,
                  isFullWidth: true,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Aktif',
                  value: controller.activeUsers.toString(),
                  color: AppColors.success(context),
                  icon: Icons.check_circle,
                  isFullWidth: true,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Pasif',
                  value: controller.inactiveUsers.toString(),
                  color: AppColors.error(context),
                  icon: Icons.cancel,
                  isFullWidth: true,
                ),
              ],
            );
          }

          // Tablet & Desktop: Yatay düzen
          return Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Toplam',
                  value: controller.totalUsers.toString(),
                  color: AppColors.info(context),
                  icon: Icons.people,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Aktif',
                  value: controller.activeUsers.toString(),
                  color: AppColors.success(context),
                  icon: Icons.check_circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Pasif',
                  value: controller.inactiveUsers.toString(),
                  color: AppColors.error(context),
                  icon: Icons.cancel,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final bool isFullWidth;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
