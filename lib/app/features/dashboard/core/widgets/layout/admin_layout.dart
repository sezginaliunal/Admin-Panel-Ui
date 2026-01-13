import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/responsive.dart';
import 'package:test_project/app/features/dashboard/core/widgets/sidebar.dart';

/// Admin panel ana layout
class AdminLayout extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AdminLayout({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final useDrawer = isMobile;

    return Scaffold(
      appBar: useDrawer ? _buildAppBar(context) : null,
      drawer: useDrawer ? const Drawer(child: Sidebar()) : null,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation:
          floatingActionButtonLocation ?? FloatingActionButtonLocation.endFloat,
      body: Row(
        children: [
          if (!useDrawer) const _DesktopSidebar(),
          const SizedBox(width: 1),
          _ContentArea(child: child),
        ],
      ),
    );
  }

  /// Mobil & Tablet AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('Admin Panel'),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();
  static const double width = 200;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: width, child: Sidebar());
  }
}

class _ContentArea extends StatelessWidget {
  final Widget child;
  const _ContentArea({required this.child});
  static const double padding = 16;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(padding: const EdgeInsets.all(padding), child: child),
    );
  }
}
