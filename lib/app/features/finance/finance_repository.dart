// lib/app/features/finance/repositories/finance_repository.dart

import 'package:test_project/app/features/finance/models/safe_model.dart';
import 'package:test_project/app/features/finance/models/transaction_model.dart';

class FinanceRepository {
  // Mock Data - API çağrıları buraya gelecek
  final List<SafeModel> _mockSafes = [
    SafeModel(
      id: 1,
      name: 'Ana Kasa',
      currency: 'TRY',
      balance: 125000.50,
      description: 'Genel işletme kasası',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    SafeModel(
      id: 2,
      name: 'Dolar Kasası',
      currency: 'USD',
      balance: 5000.00,
      description: 'Döviz işlemleri kasası',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
    ),
    SafeModel(
      id: 3,
      name: 'Euro Kasası',
      currency: 'EUR',
      balance: 3500.75,
      description: 'Euro işlemleri',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
    ),
    SafeModel(
      id: 4,
      name: 'Yedek Kasa',
      currency: 'TRY',
      balance: 0.00,
      description: 'Kullanılmayan kasa',
      isActive: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<TransactionModel> _mockTransactions = [];

  FinanceRepository() {
    _generateMockTransactions();
  }

  void _generateMockTransactions() {
    final now = DateTime.now();
    for (int i = 0; i < 50; i++) {
      _mockTransactions.add(
        TransactionModel(
          id: i + 1,
          safeId: (i % 3) + 1, // 1, 2, 3 arası dönüyor
          type: i.isEven ? TransactionType.income : TransactionType.expense,
          amount: (i + 1) * 100.0 + (i * 50),
          description: i.isEven
              ? 'Gelir ${i + 1} - Satış tahsilatı'
              : 'Gider ${i + 1} - Genel giderler',
          category: i.isEven ? 'Satış' : 'Genel Giderler',
          referenceNo: 'REF-${1000 + i}',
          date: now.subtract(Duration(days: i)),
          createdAt: now.subtract(Duration(days: i)),
        ),
      );
    }
  }

  // === SAFE OPERATIONS ===
  Future<List<SafeModel>> getSafes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockSafes;
  }

  Future<SafeModel?> getSafeById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockSafes.firstWhere((safe) => safe.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> createSafe(SafeModel safe) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockSafes.add(safe);
    return true;
  }

  Future<bool> updateSafe(SafeModel safe) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSafes.indexWhere((s) => s.id == safe.id);
    if (index != -1) {
      _mockSafes[index] = safe;
      return true;
    }
    return false;
  }

  Future<bool> deleteSafe(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockSafes.removeWhere((s) => s.id == id);
    return true;
  }

  // === TRANSACTION OPERATIONS ===
  Future<List<TransactionModel>> getTransactions({int? safeId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (safeId != null) {
      return _mockTransactions.where((t) => t.safeId == safeId).toList();
    }
    return _mockTransactions;
  }

  Future<TransactionModel?> getTransactionById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockTransactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> createTransaction(TransactionModel transaction) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _mockTransactions.insert(0, transaction);

    // Kasa bakiyesini güncelle
    final safeIndex = _mockSafes.indexWhere((s) => s.id == transaction.safeId);
    if (safeIndex != -1) {
      final safe = _mockSafes[safeIndex];
      final newBalance = transaction.isIncome
          ? safe.balance + transaction.amount
          : safe.balance - transaction.amount;

      _mockSafes[safeIndex] = safe.copyWith(
        balance: newBalance,
        updatedAt: DateTime.now(),
      );
    }

    return true;
  }

  Future<bool> deleteTransaction(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final transaction = _mockTransactions.firstWhere((t) => t.id == id);

    // Kasa bakiyesini geri al
    final safeIndex = _mockSafes.indexWhere((s) => s.id == transaction.safeId);
    if (safeIndex != -1) {
      final safe = _mockSafes[safeIndex];
      final newBalance = transaction.isIncome
          ? safe.balance - transaction.amount
          : safe.balance + transaction.amount;

      _mockSafes[safeIndex] = safe.copyWith(
        balance: newBalance,
        updatedAt: DateTime.now(),
      );
    }

    _mockTransactions.removeWhere((t) => t.id == id);
    return true;
  }

  // === STATISTICS ===
  Future<Map<String, double>> getStatistics() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final totalIncome = _mockTransactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);

    final totalExpense = _mockTransactions
        .where((t) => t.isExpense)
        .fold(0.0, (sum, t) => sum + t.amount);

    final totalBalance = _mockSafes
        .where((s) => s.isActive)
        .fold(0.0, (sum, s) => sum + s.balance);

    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'totalBalance': totalBalance,
      'netProfit': totalIncome - totalExpense,
    };
  }
}
