import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
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

      return SliverToBoxAdapter(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final spacing = 16.0;
            final cardWidth = 250.0; // Kart genişliği
            final columns = (maxWidth / (cardWidth + spacing)).floor();

            final effectiveWidth =
                (maxWidth - (columns - 1) * spacing) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: controller.stats.map((stat) {
                return SizedBox(
                  width: effectiveWidth,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 120, // Minimum yükseklik
                    ),
                    child: StatCard(
                      model: stat,
                      onTap: () => controller.onStatCardTap(stat),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
    });
  }
}
