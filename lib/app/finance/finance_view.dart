// lib/app/features/finance/finance_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'package:test_project/app/finance/dialogs/add_safe_dialog.dart';
import 'package:test_project/app/finance/dialogs/add_transaction_dialog.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/widgets/finance_header.dart';
import 'package:test_project/app/finance/widgets/safes_section.dart';
import 'package:test_project/app/finance/widgets/transactions_section.dart';

class FinanceView extends GetView<FinanceController> {
  const FinanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      floatingActionButton: _buildSpeedDial(context),
      child: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            // Header with Statistics
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: FinanceHeader(),
              ),
            ),

            // Safes Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: SafesSection(),
              ),
            ),

            // Transactions Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: TransactionsSection(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      }),
    );
  }

  // lib/app/features/finance/finance_view.dart (güncellenmiş _buildSpeedDial)
  Widget _buildSpeedDial(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Yeni Kasa
        FloatingActionButton.small(
          heroTag: 'add_safe',
          onPressed: () => Get.dialog(const AddSafeDialog()),
          backgroundColor: AppColors.primary(context),
          child: const Icon(Icons.account_balance_wallet),
        ),
        const SizedBox(height: 12),

        // Gelir Ekle
        FloatingActionButton.small(
          heroTag: 'add_income',
          backgroundColor: AppColors.success(context),
          onPressed: () =>
              Get.dialog(const AddTransactionDialog(isIncome: true)),
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 12),

        // Gider Ekle
        FloatingActionButton.small(
          heroTag: 'add_expense',
          backgroundColor: AppColors.error(context),
          onPressed: () =>
              Get.dialog(const AddTransactionDialog(isIncome: false)),
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
