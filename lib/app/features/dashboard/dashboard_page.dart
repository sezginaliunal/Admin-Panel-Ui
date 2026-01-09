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
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        const SliverToBoxAdapter(child: _UsersTable()),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

class _UsersTable extends StatelessWidget {
  const _UsersTable();

  static const double idWidth = 60;
  static const double nameWidth = 180;
  static const double emailWidth = 240;
  static const double roleWidth = 120;
  static const double statusWidth = 120;
  static const double actionWidth = 120;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 0,
            headingRowHeight: 48,
            dataRowHeight: 52,
            columns: const [
              DataColumn(
                label: SizedBox(width: idWidth, child: Text('ID')),
              ),
              DataColumn(
                label: SizedBox(width: nameWidth, child: Text('Ad Soyad')),
              ),
              DataColumn(
                label: SizedBox(width: emailWidth, child: Text('E-posta')),
              ),
              DataColumn(
                label: SizedBox(width: roleWidth, child: Text('Rol')),
              ),
              DataColumn(
                label: SizedBox(width: statusWidth, child: Text('Durum')),
              ),
              DataColumn(
                label: SizedBox(width: actionWidth, child: Text('İşlem')),
              ),
            ],
            rows: List.generate(20, (index) {
              return DataRow(
                cells: [
                  DataCell(
                    SizedBox(width: idWidth, child: Text('#${index + 1}')),
                  ),
                  DataCell(
                    SizedBox(
                      width: nameWidth,
                      child: Text(
                        'Kullanıcı ${index + 1}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: emailWidth,
                      child: Text(
                        'user${index + 1}@mail.com',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: roleWidth,
                      child: Text(index.isEven ? 'Admin' : 'User'),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: statusWidth,
                      child: Chip(
                        label: Text(index.isEven ? 'Aktif' : 'Pasif'),
                        backgroundColor: index.isEven
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: actionWidth,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 18),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
