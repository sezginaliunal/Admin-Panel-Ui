// lib/app/features/finance/models/transaction_model.dart
enum TransactionType { income, expense }

class TransactionModel {
  final int id;
  final int safeId;
  final TransactionType type;
  final double amount;
  final String description;
  final String? category;
  final String? referenceNo;
  final DateTime date;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.safeId,
    required this.type,
    required this.amount,
    required this.description,
    this.category,
    this.referenceNo,
    required this.date,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      safeId: json['safeId'] as int,
      type: json['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String?,
      referenceNo: json['referenceNo'] as String?,
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'safeId': safeId,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'amount': amount,
      'description': description,
      'category': category,
      'referenceNo': referenceNo,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  TransactionModel copyWith({
    int? id,
    int? safeId,
    TransactionType? type,
    double? amount,
    String? description,
    String? category,
    String? referenceNo,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      safeId: safeId ?? this.safeId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      referenceNo: referenceNo ?? this.referenceNo,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
}
