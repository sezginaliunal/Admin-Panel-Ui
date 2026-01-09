import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:test_project/app/features/dashboard/core/utils/responsive_grid.dart';
import 'package:test_project/app/features/dashboard/core/widgets/stat_card.dart';
import '../dashboard_controller.dart';

class DashboardGrid extends StatelessWidget {
  final DashboardController controller;

  const DashboardGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return SliverLayoutBuilder(
        builder: (context, constraints) {
          final gridConfig = ResponsiveGrid.calculate(
            constraints.crossAxisExtent,
          );

          return SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final stat = controller.stats[index];
                return StatCard(
                  model: stat,
                  onTap: () => controller.onStatCardTap(stat),
                );
              }, childCount: controller.stats.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridConfig.columns,
                crossAxisSpacing: gridConfig.spacing,
                mainAxisSpacing: gridConfig.spacing,
                childAspectRatio: gridConfig.aspectRatio,
              ),
            ),
          );
        },
      );
    });
  }
}
