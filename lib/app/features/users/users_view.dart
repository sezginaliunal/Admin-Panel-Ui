// lib/app/features/users/users_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'package:test_project/app/features/users/users_controller.dart';
import 'package:test_project/app/features/users/widgets/users_card.dart';
import 'package:test_project/app/features/users/widgets/users_filters.dart';
import 'package:test_project/app/features/users/widgets/users_header.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Yeni kullanıcı ekleme
          Get.toNamed('/users/add');
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Yeni Kullanıcı'),
      ),
      child: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            // Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: UsersHeader(),
              ),
            ),

            // Filters
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: UsersFilters(),
              ),
            ),

            // User List
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final user = controller.users[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: UserCard(user: user),
                  );
                }, childCount: controller.users.length),
              ),
            ),

            // Empty state
            if (controller.users.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Kullanıcı bulunamadı',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        );
      }),
    );
  }
}
