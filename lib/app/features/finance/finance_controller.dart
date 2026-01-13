// lib/app/features/finance/finance_controller.dart
import 'package:get/get.dart';
import 'package:test_project/app/features/finance/finance_repository.dart';
import 'package:test_project/app/features/finance/models/safe_model.dart';
import 'package:test_project/app/features/finance/models/transaction_model.dart';

class FinanceController extends GetxController {
  final FinanceRepository _repository = FinanceRepository();

  // State Management
  final RxList<SafeModel> _safes = <SafeModel>[].obs;
  final RxList<TransactionModel> _transactions = <TransactionModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingTransactions = false.obs;
  final Rx<SafeModel?> _selectedSafe = Rx<SafeModel?>(null);

  // Statistics
  final RxDouble _totalIncome = 0.0.obs;
  final RxDouble _totalExpense = 0.0.obs;
  final RxDouble _totalBalance = 0.0.obs;
  final RxDouble _netProfit = 0.0.obs;

  // Getters
  List<SafeModel> get safes => _safes;
  List<SafeModel> get activeSafes => _safes.where((s) => s.isActive).toList();
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading.value;
  bool get isLoadingTransactions => _isLoadingTransactions.value;
  SafeModel? get selectedSafe => _selectedSafe.value;

  double get totalIncome => _totalIncome.value;
  double get totalExpense => _totalExpense.value;
  double get totalBalance => _totalBalance.value;
  double get netProfit => _netProfit.value;

  @override
  void onInit() {
    super.onInit();
    fetchSafes();
    fetchTransactions();
    fetchStatistics();
  }

  // === SAFE OPERATIONS ===
  Future<void> fetchSafes() async {
    try {
      _isLoading.value = true;
      final safes = await _repository.getSafes();
      _safes.value = safes;
    } catch (e) {
      Get.snackbar('Hata', 'Kasalar yüklenemedi: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> createSafe(SafeModel safe) async {
    try {
      final success = await _repository.createSafe(safe);
      if (success) {
        await fetchSafes();
        Get.back();
        Get.snackbar('Başarılı', 'Kasa oluşturuldu');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Kasa oluşturulamadı: $e');
    }
  }

  Future<void> updateSafe(SafeModel safe) async {
    try {
      final success = await _repository.updateSafe(safe);
      if (success) {
        await fetchSafes();
        Get.back();
        Get.snackbar('Başarılı', 'Kasa güncellendi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Kasa güncellenemedi: $e');
    }
  }

  Future<void> deleteSafe(int id) async {
    try {
      final success = await _repository.deleteSafe(id);
      if (success) {
        await fetchSafes();
        Get.snackbar('Başarılı', 'Kasa silindi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Kasa silinemedi: $e');
    }
  }

  void selectSafe(SafeModel? safe) {
    _selectedSafe.value = safe;
    if (safe != null) {
      fetchTransactionsBySafe(safe.id);
    } else {
      fetchTransactions();
    }
  }

  // === TRANSACTION OPERATIONS ===
  Future<void> fetchTransactions() async {
    try {
      _isLoadingTransactions.value = true;
      final transactions = await _repository.getTransactions();
      _transactions.value = transactions;
    } catch (e) {
      Get.snackbar('Hata', 'Hareketler yüklenemedi: $e');
    } finally {
      _isLoadingTransactions.value = false;
    }
  }

  Future<void> fetchTransactionsBySafe(int safeId) async {
    try {
      _isLoadingTransactions.value = true;
      final transactions = await _repository.getTransactions(safeId: safeId);
      _transactions.value = transactions;
    } catch (e) {
      Get.snackbar('Hata', 'Hareketler yüklenemedi: $e');
    } finally {
      _isLoadingTransactions.value = false;
    }
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      final success = await _repository.createTransaction(transaction);
      if (success) {
        await fetchSafes();
        await fetchTransactions();
        await fetchStatistics();
        Get.back();
        Get.snackbar('Başarılı', 'Hareket eklendi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Hareket eklenemedi: $e');
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      final success = await _repository.deleteTransaction(id);
      if (success) {
        await fetchSafes();
        await fetchTransactions();
        await fetchStatistics();
        Get.snackbar('Başarılı', 'Hareket silindi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Hareket silinemedi: $e');
    }
  }

  // === STATISTICS ===
  Future<void> fetchStatistics() async {
    try {
      final stats = await _repository.getStatistics();
      _totalIncome.value = stats['totalIncome'] ?? 0.0;
      _totalExpense.value = stats['totalExpense'] ?? 0.0;
      _totalBalance.value = stats['totalBalance'] ?? 0.0;
      _netProfit.value = stats['netProfit'] ?? 0.0;
    } catch (e) {
      Get.snackbar('Hata', 'İstatistikler yüklenemedi: $e');
    }
  }

  // === HELPERS ===
  String formatCurrency(double amount, String currency) {
    final symbol = _getCurrencySymbol(currency);
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'TRY':
        return '₺';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return currency;
    }
  }
}
