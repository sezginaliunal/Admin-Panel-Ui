import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/widgets/content.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(child: DashboardContent(controller: controller));
  }
}
