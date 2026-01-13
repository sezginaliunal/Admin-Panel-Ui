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

        return LayoutBuilder(
          builder: (context, constraints) {
            final gridConfig = PackageGridConfig.calculate(
              constraints.maxWidth,
            );

            return CustomScrollView(
              slivers: [
                /// HEADER
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lisans Paketleri',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'İhtiyacınıza en uygun paketi seçin',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                /// STAGGERED GRID - MASONRY LAYOUT
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: gridConfig.columns,
                    mainAxisSpacing: gridConfig.spacing,
                    crossAxisSpacing: gridConfig.spacing,
                    childCount: controller.packages.length,
                    itemBuilder: (context, index) {
                      return PackageCard(package: controller.packages[index]);
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        );
      }),
    );
  }
}
