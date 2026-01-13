// lib/app/features/finance/widgets/transaction_item.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/models/safe_model.dart';
import 'package:test_project/app/finance/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FinanceController>();
    final safe = controller.safes.firstWhereOrNull(
      (s) => s.id == transaction.safeId,
    );

    final isSmall = MediaQuery.of(context).size.width < 500;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder(context)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _icon(context),
              const SizedBox(width: 12),
              Expanded(child: _content(context, controller, safe, isSmall)),
              if (!isSmall) _deleteButton(context, controller),
            ],
          ),
          if (isSmall)
            Align(
              alignment: Alignment.centerRight,
              child: _deleteButton(context, controller),
            ),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: transaction.isIncome
            ? AppColors.success(context).withOpacity(0.1)
            : AppColors.error(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        transaction.isIncome ? Icons.arrow_upward : Icons.arrow_downward,
        color: transaction.isIncome
            ? AppColors.success(context)
            : AppColors.error(context),
        size: 24,
      ),
    );
  }

  Widget _content(
    BuildContext context,
    FinanceController controller,
    SafeModel? safe,
    bool isSmall,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isSmall) ...[
          Text(
            transaction.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            controller.formatCurrency(
              transaction.amount,
              safe?.currency ?? 'TRY',
            ),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: transaction.isIncome
                  ? AppColors.success(context)
                  : AppColors.error(context),
            ),
          ),
        ] else ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  transaction.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface(context),
                  ),
                ),
              ),
              Text(
                controller.formatCurrency(
                  transaction.amount,
                  safe?.currency ?? 'TRY',
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: transaction.isIncome
                      ? AppColors.success(context)
                      : AppColors.error(context),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        _meta(context, safe),
      ],
    );
  }

  Widget _meta(BuildContext context, SafeModel? safe) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (transaction.category != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary(context).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              transaction.category!,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primary(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ...[
          Icon(
            Icons.account_balance_wallet,
            size: 14,
            color: AppColors.iconSecondary(context),
          ),
          Text(
            safe?.name ?? '-',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceVariant(context),
            ),
          ),
        ],
        Icon(
          Icons.calendar_today,
          size: 14,
          color: AppColors.iconSecondary(context),
        ),
        Text(
          DateFormat('dd MMM yyyy').format(transaction.date),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.onSurfaceVariant(context),
          ),
        ),
      ],
    );
  }

  Widget _deleteButton(BuildContext context, FinanceController controller) {
    return IconButton(
      onPressed: () => _showDeleteDialog(context, controller, transaction.id),
      icon: Icon(
        Icons.delete_outline,
        color: AppColors.error(context),
        size: 20,
      ),
      tooltip: 'Sil',
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    FinanceController controller,
    int transactionId,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hareketi Sil'),
        content: const Text('Bu hareketi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('İptal')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteTransaction(transactionId);
            },
            child: Text(
              'Sil',
              style: TextStyle(color: AppColors.error(context)),
            ),
          ),
        ],
      ),
    );
  }
}
