// lib/app/features/users/widgets/users_filters.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/users/users_controller.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/responsive.dart';

class UsersFilters extends GetView<UsersController> {
  const UsersFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        // Search Bar
        TextField(
          onChanged: controller.search,
          decoration: InputDecoration(
            hintText: 'Kullanıcı ara...',
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.iconSecondary(context),
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant(context).withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.outline(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.outline(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primary(context),
                width: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Filters - Responsive Layout
        Obx(() {
          // Mobile: Dikey düzen
          if (isMobile) {
            return Column(
              children: [
                // Role Filter
                DropdownButtonFormField<String>(
                  initialValue: controller.selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: AppColors.iconSecondary(context),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceVariant(
                      context,
                    ).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.outline(context)),
                    ),
                  ),
                  items: controller.availableRoles.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.filterByRole(value);
                  },
                ),

                const SizedBox(height: 12),

                // Active Filter & Clear Button Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: FilterChip(
                          label: const Text('Sadece Aktifler'),
                          selected: controller.showActiveOnly,
                          onSelected: controller.toggleActiveFilter,
                          avatar: Icon(
                            controller.showActiveOnly
                                ? Icons.check
                                : Icons.circle_outlined,
                            size: 18,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.error(context).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.error(context).withOpacity(0.3),
                        ),
                      ),
                      child: IconButton(
                        onPressed: controller.clearFilters,
                        icon: Icon(
                          Icons.clear_all,
                          color: AppColors.error(context),
                        ),
                        tooltip: 'Filtreleri Temizle',
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          // Tablet & Desktop: Yatay düzen
          return Row(
            children: [
              // Role Filter
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  initialValue: controller.selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: AppColors.iconSecondary(context),
                    ),
                    filled: true,
                    fillColor: AppColors.surfaceVariant(
                      context,
                    ).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.outline(context)),
                    ),
                  ),
                  items: controller.availableRoles.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.filterByRole(value);
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Active Filter
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 56,
                  child: FilterChip(
                    label: const Text('Sadece Aktifler'),
                    selected: controller.showActiveOnly,
                    onSelected: controller.toggleActiveFilter,
                    avatar: Icon(
                      controller.showActiveOnly
                          ? Icons.check
                          : Icons.circle_outlined,
                      size: 18,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Clear Filters Button
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.error(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error(context).withOpacity(0.3),
                  ),
                ),
                child: IconButton(
                  onPressed: controller.clearFilters,
                  icon: Icon(Icons.clear_all, color: AppColors.error(context)),
                  tooltip: 'Filtreleri Temizle',
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
