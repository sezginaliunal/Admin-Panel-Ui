import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/dashboard_controller.dart';
import 'package:test_project/app/features/dashboard/widgets/dashboard_grid.dart';

class DashboardContent extends StatelessWidget {
  final DashboardController controller;

  const DashboardContent({required this.controller});

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
