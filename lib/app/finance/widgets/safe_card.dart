// lib/app/features/finance/widgets/safe_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/finance/dialogs/edit_safe_dialog.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/models/safe_model.dart';

class SafeCard extends StatelessWidget {
  final SafeModel safe;

  const SafeCard({super.key, required this.safe});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FinanceController>();

    return InkWell(
      onTap: () => controller.selectSafe(safe),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: safe.isActive
                ? [
                    AppColors.primary(context),
                    AppColors.primary(context).withOpacity(0.7),
                  ]
                : [
                    AppColors.surfaceVariant(context),
                    AppColors.surfaceVariant(context).withOpacity(0.7),
                  ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow(context),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 🔥 KRİTİK
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, controller),
            const SizedBox(height: 12),
            _info(context),
            const SizedBox(height: 16), // Spacer yerine bu
            _balance(context, controller),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header(BuildContext context, FinanceController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.account_balance_wallet,
            color: safe.isActive
                ? Colors.white
                : AppColors.iconDisabled(context),
            size: 22,
          ),
        ),
        PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.more_vert,
            color: safe.isActive
                ? Colors.white
                : AppColors.iconSecondary(context),
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
              onTap: () => Future.delayed(
                Duration.zero,
                () => Get.dialog(EditSafeDialog(safe: safe)),
              ),
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: AppColors.error(context)),
                  const SizedBox(width: 8),
                  Text(
                    'Sil',
                    style: TextStyle(color: AppColors.error(context)),
                  ),
                ],
              ),
              onTap: () => _showDeleteDialog(context, controller, safe.id),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- INFO ----------------
  Widget _info(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          safe.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: safe.isActive ? Colors.white : AppColors.onSurface(context),
          ),
        ),
        if (safe.description != null) ...[
          const SizedBox(height: 4),
          Text(
            safe.description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: safe.isActive
                  ? Colors.white.withOpacity(0.8)
                  : AppColors.onSurfaceVariant(context),
            ),
          ),
        ],
      ],
    );
  }

  // ---------------- BALANCE ----------------
  Widget _balance(BuildContext context, FinanceController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bakiye',
          style: TextStyle(
            fontSize: 12,
            color: safe.isActive
                ? Colors.white.withOpacity(0.8)
                : AppColors.onSurfaceVariant(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          controller.formatCurrency(safe.balance, safe.currency),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20, // 🔽 küçültüldü
            fontWeight: FontWeight.bold,
            color: safe.isActive ? Colors.white : AppColors.onSurface(context),
          ),
        ),
      ],
    );
  }

  // ---------------- DELETE ----------------
  void _showDeleteDialog(
    BuildContext context,
    FinanceController controller,
    int safeId,
  ) {
    Future.delayed(Duration.zero, () {
      Get.dialog(
        AlertDialog(
          title: const Text('Kasayı Sil'),
          content: const Text('Bu kasayı silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
            TextButton(
              onPressed: () {
                Get.back();
                controller.deleteSafe(safeId);
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
