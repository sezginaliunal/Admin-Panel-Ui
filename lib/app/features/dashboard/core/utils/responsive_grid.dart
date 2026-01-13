/// Responsive grid yapılandırması
/// Responsive grid yapılandırması
class GridConfig {
  final int columns;
  final double spacing;
  final double aspectRatio;
  final double? mainAxisExtent;

  const GridConfig({
    required this.columns,
    required this.spacing,
    required this.aspectRatio,
    this.mainAxisExtent,
  });
}

class ResponsiveGrid {
  ResponsiveGrid._();

  static const double _mobileBreakpoint = 600.0;
  static const double _tabletBreakpoint = 900.0;
  static const double _largeTabletBreakpoint = 1200.0;
  static const double _desktopBreakpoint = 1440.0;
  static const double _defaultSpacing = 8.0;

  static GridConfig calculate(double width) {
    return GridConfig(
      columns: _getColumnCount(width),
      spacing: _defaultSpacing,
      aspectRatio: _getAspectRatio(width),
      mainAxisExtent: _getMainAxisExtent(width),
    );
  }

  static int _getColumnCount(double width) {
    if (width < _mobileBreakpoint) return 2;
    if (width < _tabletBreakpoint) return 3;
    if (width < _largeTabletBreakpoint) return 4;
    if (width < _desktopBreakpoint) return 5;
    return 5;
  }

  static double _getAspectRatio(double width) {
    if (width < _mobileBreakpoint) return 2.0;
    if (width < _tabletBreakpoint) return 2.2;
    if (width < _largeTabletBreakpoint) return 2.5;
    if (width < _desktopBreakpoint) return 3.0;
    return 3.5;
  }

  // Sabit yükseklik kullanarak overflow'u önle
  static double? _getMainAxisExtent(double width) {
    if (width < _mobileBreakpoint) return 100.0;
    if (width < _tabletBreakpoint) return 110.0;
    if (width < _largeTabletBreakpoint) return 120.0;
    return null; // Büyük ekranlarda aspectRatio kullan
  }
}

/// Paket sayfası için özelleştirilmiş grid yapılandırması
class PackageGridConfig {
  final int columns;
  final double spacing;

  const PackageGridConfig({required this.columns, required this.spacing});

  static PackageGridConfig calculate(double width) {
    return PackageGridConfig(
      columns: _getColumnCount(width),
      spacing: _getSpacing(width),
    );
  }

  static int _getColumnCount(double width) {
    if (width < 600) return 1; // Mobile: 1 kolon
    if (width < 900) return 2; // Tablet: 2 kolon
    if (width < 1200) return 3; // Large Tablet: 3 kolon
    return 4; // Desktop: 4 kolon
  }

  static double _getSpacing(double width) {
    if (width < 600) return 16.0; // Mobile: daha az boşluk
    if (width < 900) return 20.0; // Tablet
    return 20.0; // Desktop
  }
}
