import 'package:flutter/material.dart';

/// Responsive grid yapılandırması
class GridConfig {
  final int columns;
  final double spacing;
  final double aspectRatio;

  const GridConfig({
    required this.columns,
    required this.spacing,
    required this.aspectRatio,
  });
}

/// Responsive grid hesaplama yardımcı sınıfı
///
/// Ekran genişliğine göre grid yapılandırmasını hesaplar
class ResponsiveGrid {
  ResponsiveGrid._();

  // Breakpoint sabitleri
  static const double _mobileBreakpoint = 600.0;
  static const double _tabletBreakpoint = 900.0;
  static const double _desktopBreakpoint = 1200.0;

  // Grid yapılandırma sabitleri
  static const double _defaultSpacing = 16.0;
  static const double _defaultAspectRatio = 1.6;

  /// Ekran genişliğine göre grid sütun sayısını hesaplar
  static GridConfig calculateColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridConfig(
      columns: _getColumnCount(width),
      spacing: _defaultSpacing,
      aspectRatio: _defaultAspectRatio,
    );
  }

  /// Genişliğe göre sütun sayısını döndürür
  static int _getColumnCount(double width) {
    if (width < _mobileBreakpoint) return 2;
    if (width < _tabletBreakpoint) return 2;
    if (width < _desktopBreakpoint) return 3;
    return 4;
  }
}
