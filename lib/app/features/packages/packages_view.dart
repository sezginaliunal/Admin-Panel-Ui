import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_project/app/features/dashboard/core/utils/responsive_grid.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'package:test_project/app/features/packages/packages_controller.dart';
import 'package:test_project/app/features/packages/widgets/package_card.dart';

class PackagesView extends GetView<PackagesController> {
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final gridConfig = PackageGridConfig.calculate(width);

    return AdminLayout(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Yeni Paket'),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            SliverMasonryGrid.count(
              crossAxisCount: gridConfig.columns,
              mainAxisSpacing: gridConfig.spacing,
              crossAxisSpacing: gridConfig.spacing,
              childCount: controller.packages.length,
              itemBuilder: (context, index) {
                return PackageCard(package: controller.packages[index]);
              },
            ),
          ],
        );
      }),
    );
  }
}
