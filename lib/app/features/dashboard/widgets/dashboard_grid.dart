import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:test_project/core/utils/responsive_grid.dart';
import 'package:test_project/core/widgets/stat_card.dart';
import '../dashboard_controller.dart';

/// Dashboard grid görünümü
///
/// İstatistik kartlarını responsive grid düzeninde gösterir
/// Animasyonlu yükleme ve stagger effect içerir
class DashboardGrid extends StatelessWidget {
  final DashboardController controller;

  const DashboardGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isTrue
          ? _buildLoadingState()
          : _buildGridView(context),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildGridView(BuildContext context) {
    final gridConfig = ResponsiveGrid.calculateColumns(context);

    return RefreshIndicator(
      onRefresh: controller.refreshStats,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: DashboardGridStyle.gridPadding,
        itemCount: controller.stats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridConfig.columns,
          crossAxisSpacing: gridConfig.spacing,
          mainAxisSpacing: gridConfig.spacing,
          childAspectRatio: gridConfig.aspectRatio,
        ),
        itemBuilder: (context, index) => _buildAnimatedCard(index),
      ),
    );
  }

  Widget _buildAnimatedCard(int index) {
    final stat = controller.stats[index];

    return TweenAnimationBuilder<double>(
      duration: Duration(
        milliseconds:
            DashboardGridAnimation.baseDelay +
            (index * DashboardGridAnimation.staggerDelay),
      ),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, DashboardGridAnimation.slideDistance * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: StatCard(model: stat, onTap: () => controller.onStatCardTap(stat)),
    );
  }
}

/// Dashboard grid animasyon sabitleri
class DashboardGridAnimation {
  static const int baseDelay = 100;
  static const int staggerDelay = 50;
  static const double slideDistance = 20.0;

  const DashboardGridAnimation._();
}

/// Dashboard grid stil sabitleri
class DashboardGridStyle {
  static const EdgeInsets gridPadding = EdgeInsets.all(16.0);

  const DashboardGridStyle._();
}
