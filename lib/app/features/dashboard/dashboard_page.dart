import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/widgets/dashboard_grid.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'dashboard_controller.dart';

/// Dashboard sayfası
///
/// Admin panelinin ana sayfasını temsil eder ve istatistikleri görüntüler
/// GetView pattern'i kullanarak controller'a otomatik erişim sağlar
class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(child: _DashboardContent(controller: controller));
  }
}

/// Dashboard içerik widgetı
///
/// Ana dashboard içeriğini yönetir
class _DashboardContent extends StatelessWidget {
  final DashboardController controller;

  const _DashboardContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        DashboardGrid(controller: controller),
        // SliverToBoxAdapter(child: UsersPage()),
      ],
    );
  }
}
