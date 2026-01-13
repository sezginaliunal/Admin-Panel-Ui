// lib/app/features/users/widgets/user_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/models/user_model.dart';
import 'package:test_project/app/features/users/users_controller.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UsersController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow(context),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: user.isActive
                ? AppColors.success(context).withOpacity(0.2)
                : AppColors.error(context).withOpacity(0.2),
            child: Text(
              user.name[0].toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: user.isActive
                    ? AppColors.success(context)
                    : AppColors.error(context),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant(context),
                  ),
                ),
              ],
            ),
          ),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: user.role == 'Admin'
                  ? AppColors.primary(context).withOpacity(0.1)
                  : AppColors.secondary(context).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              user.role,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: user.role == 'Admin'
                    ? AppColors.primary(context)
                    : AppColors.secondary(context),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Status Switch
          Switch(
            value: user.isActive,
            onChanged: (value) => controller.toggleUserStatus(user),
            activeThumbColor: AppColors.success(context),
          ),

          // Actions Menu
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.iconSecondary(context),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('Düzenle'),
                  ],
                ),
                onTap: () {
                  // Edit user
                  Get.toNamed('/users/edit/${user.id}');
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 20,
                      color: AppColors.error(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sil',
                      style: TextStyle(color: AppColors.error(context)),
                    ),
                  ],
                ),
                onTap: () => _showDeleteDialog(context, controller, user.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    UsersController controller,
    int userId,
  ) {
    Future.delayed(Duration.zero, () {
      Get.dialog(
        AlertDialog(
          title: const Text('Kullanıcıyı Sil'),
          content: const Text(
            'Bu kullanıcıyı silmek istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
            TextButton(
              onPressed: () {
                Get.back();
                controller.deleteUser(userId);
              },
              child: Text(
                'Sil',
                style: TextStyle(color: AppColors.error(context)),
              ),
            ),
          ],
        ),
      );
    });
  }
}
