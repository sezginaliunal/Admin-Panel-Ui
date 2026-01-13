// lib/app/features/finance/widgets/finance_header.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/responsive.dart';
import 'package:test_project/app/features/finance/finance_controller.dart';

class FinanceHeader extends GetView<FinanceController> {
  const FinanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Finans Yönetimi',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Kasalar ve hareketler',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),

        // Statistics Cards
        Obx(() {
          final isMobile = Responsive.isMobile(context);

          if (isMobile) {
            return Column(
              children: [
                _StatCard(
                  title: 'Toplam Bakiye',
                  value: controller.formatCurrency(
                    controller.totalBalance,
                    'TRY',
                  ),
                  color: AppColors.info(context),
                  icon: Icons.account_balance,
                  isFullWidth: true,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Toplam Gelir',
                  value: controller.formatCurrency(
                    controller.totalIncome,
                    'TRY',
                  ),
                  color: AppColors.success(context),
                  icon: Icons.arrow_upward,
                  isFullWidth: true,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Toplam Gider',
                  value: controller.formatCurrency(
                    controller.totalExpense,
                    'TRY',
                  ),
                  color: AppColors.error(context),
                  icon: Icons.arrow_downward,
                  isFullWidth: true,
                ),
                const SizedBox(height: 12),
                _StatCard(
                  title: 'Net Kar/Zarar',
                  value: controller.formatCurrency(controller.netProfit, 'TRY'),
                  color: controller.netProfit >= 0
                      ? AppColors.success(context)
                      : AppColors.error(context),
                  icon: controller.netProfit >= 0
                      ? Icons.trending_up
                      : Icons.trending_down,
                  isFullWidth: true,
                ),
              ],
            );
          }

          // Desktop/Tablet
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 84) / 4,
                child: _StatCard(
                  title: 'Toplam Bakiye',
                  value: controller.formatCurrency(
                    controller.totalBalance,
                    'TRY',
                  ),
                  color: AppColors.info(context),
                  icon: Icons.account_balance,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 84) / 4,
                child: _StatCard(
                  title: 'Toplam Gelir',
                  value: controller.formatCurrency(
                    controller.totalIncome,
                    'TRY',
                  ),
                  color: AppColors.success(context),
                  icon: Icons.arrow_upward,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 84) / 4,
                child: _StatCard(
                  title: 'Toplam Gider',
                  value: controller.formatCurrency(
                    controller.totalExpense,
                    'TRY',
                  ),
                  color: AppColors.error(context),
                  icon: Icons.arrow_downward,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 84) / 4,
                child: _StatCard(
                  title: 'Net Kar/Zarar',
                  value: controller.formatCurrency(controller.netProfit, 'TRY'),
                  color: controller.netProfit >= 0
                      ? AppColors.success(context)
                      : AppColors.error(context),
                  icon: controller.netProfit >= 0
                      ? Icons.trending_up
                      : Icons.trending_down,
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
                    fontSize: 20,
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
