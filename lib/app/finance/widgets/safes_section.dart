// lib/app/features/finance/widgets/safes_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/widgets/safe_card.dart';

// lib/app/features/finance/widgets/safes_section.dart
class SafesSection extends GetView<FinanceController> {
  const SafesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        const SizedBox(height: 16),
        _content(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 8,
      children: [
        Text(
          'Kasalar',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Obx(
          () => Text(
            '${controller.activeSafes.length} aktif kasa',
            style: TextStyle(
              color: AppColors.onSurfaceVariant(context),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Obx(() {
      if (controller.safes.isEmpty) {
        return _empty(context);
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          // 🔥 kritik
          child: Row(
            children: controller.safes.map((safe) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 220,
                    maxWidth: 320,
                  ),
                  child: SafeCard(safe: safe),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _empty(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant(context).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 48,
            color: AppColors.iconSecondary(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kasa eklenmemiş',
            style: TextStyle(color: AppColors.onSurfaceVariant(context)),
          ),
        ],
      ),
    );
  }
}
