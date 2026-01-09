import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/responsive.dart';
import 'package:test_project/app/features/dashboard/core/widgets/sidebar.dart';

/// Admin panel düzeni
///
/// Sidebar ve içerik alanını responsive olarak yönetir
class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: isMobile ? _buildAppBar(context) : null,
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  /// AppBar oluşturur
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar();
  }

  /// Mobil görünümde drawer oluşturur
  Widget? _buildDrawer(BuildContext context) {
    return Responsive.isMobile(context) ? const Drawer(child: Sidebar()) : null;
  }

  /// Ana içerik alanını oluşturur
  Widget _buildBody(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isMobile(context)) const _DesktopSidebar(),
        _ContentArea(child: child),
      ],
    );
  }
}

/// Masaüstü görünümünde sidebar
class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();

  static const double width = 260.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: width, child: Sidebar());
  }
}

/// İçerik alanı wrapper'ı
class _ContentArea extends StatelessWidget {
  final Widget child;

  const _ContentArea({required this.child});

  static const double padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(padding: const EdgeInsets.all(padding), child: child),
    );
  }
}
