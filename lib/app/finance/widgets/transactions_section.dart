// lib/app/features/finance/widgets/transactions_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/transaction_item.dart';

class TransactionsSection extends GetView<FinanceController> {
  const TransactionsSection({super.key});

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
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hareketler',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Obx(() {
              final safe = controller.selectedSafe;
              return Text(
                safe?.name ?? 'Tüm kasalar',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.onSurfaceVariant(context),
                ),
              );
            }),
          ],
        ),
        Obx(() {
          if (controller.selectedSafe != null) {
            return TextButton.icon(
              onPressed: () => controller.selectSafe(null),
              icon: const Icon(Icons.clear, size: 18),
              label: const Text('Tümünü Göster'),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingTransactions) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.transactions.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant(context).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: AppColors.iconSecondary(context),
              ),
              const SizedBox(height: 16),
              Text(
                'Henüz hareket kaydı yok',
                style: TextStyle(color: AppColors.onSurfaceVariant(context)),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return TransactionItem(transaction: controller.transactions[index]);
        },
      );
    });
  }
}
