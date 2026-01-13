// lib/app/features/finance/models/safe_model.dart
class SafeModel {
  final int id;
  final String name;
  final String currency;
  final double balance;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SafeModel({
    required this.id,
    required this.name,
    required this.currency,
    required this.balance,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SafeModel.fromJson(Map<String, dynamic> json) {
    return SafeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      currency: json['currency'] as String,
      balance: (json['balance'] as num).toDouble(),
      description: json['description'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'balance': balance,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  SafeModel copyWith({
    int? id,
    String? name,
    String? currency,
    double? balance,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SafeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
