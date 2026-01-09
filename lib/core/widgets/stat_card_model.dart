import 'package:flutter/material.dart';

/// İstatistik kartı veri modeli
///
/// StatCard widget'ının göstereceği verileri tutar
class StatCardModel {
  final String id;
  final String title;
  final String value;
  final IconData? icon;
  final Color? accentColor;
  final String? subtitle;
  final double? trend;
  final String? trendLabel;

  const StatCardModel({
    required this.id,
    required this.title,
    required this.value,
    this.icon,
    this.accentColor,
    this.subtitle,
    this.trend,
    this.trendLabel,
  });

  /// JSON'dan model oluşturur
  factory StatCardModel.fromJson(Map<String, dynamic> json) {
    return StatCardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      value: json['value'] as String,
      icon: _parseIcon(json['icon']),
      accentColor: _parseColor(json['accentColor']),
      subtitle: json['subtitle'] as String?,
      trend: json['trend'] as double?,
      trendLabel: json['trendLabel'] as String?,
    );
  }

  /// Model'i JSON'a çevirir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'icon': icon?.codePoint,
      'accentColor': accentColor?.value,
      'subtitle': subtitle,
      'trend': trend,
      'trendLabel': trendLabel,
    };
  }

  /// İkon parse eder
  static IconData? _parseIcon(dynamic iconData) {
    if (iconData == null) return null;
    if (iconData is int) {
      return IconData(iconData, fontFamily: 'MaterialIcons');
    }
    return null;
  }

  /// Renk parse eder
  static Color? _parseColor(dynamic colorData) {
    if (colorData == null) return null;
    if (colorData is int) {
      return Color(colorData);
    }
    return null;
  }

  /// Kopya oluşturur (immutability için)
  StatCardModel copyWith({
    String? id,
    String? title,
    String? value,
    IconData? icon,
    Color? accentColor,
    String? subtitle,
    double? trend,
    String? trendLabel,
  }) {
    return StatCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      icon: icon ?? this.icon,
      accentColor: accentColor ?? this.accentColor,
      subtitle: subtitle ?? this.subtitle,
      trend: trend ?? this.trend,
      trendLabel: trendLabel ?? this.trendLabel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatCardModel &&
        other.id == id &&
        other.title == title &&
        other.value == value &&
        other.icon == icon &&
        other.accentColor == accentColor &&
        other.subtitle == subtitle &&
        other.trend == trend &&
        other.trendLabel == trendLabel;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      value,
      icon,
      accentColor,
      subtitle,
      trend,
      trendLabel,
    );
  }
}
