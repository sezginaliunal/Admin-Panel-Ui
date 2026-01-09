import 'package:flutter/material.dart';

/// Sidebar başlık widgetı
///
/// Uygulamanın logosunu veya başlığını gösterir
class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key});

  static const double topSpacing = 40.0;
  static const double bottomSpacing = 30.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: topSpacing),
        _buildTitle(),
        const SizedBox(height: bottomSpacing),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text('ADMIN', style: _HeaderTextStyle());
  }
}

/// Başlık text stili
class _HeaderTextStyle extends TextStyle {
  const _HeaderTextStyle()
    : super(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold);
}
