// lib/app/features/users/users_controller.dart
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/models/user_model.dart';
import 'package:test_project/app/features/users/users_repository.dart';

class UsersController extends GetxController {
  final UserRepository _repository = UserRepository();

  // State Management
  final RxList<UserModel> _allUsers = <UserModel>[].obs;
  final RxList<UserModel> _filteredUsers = <UserModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _selectedRole = 'All'.obs;
  final RxBool _showActiveOnly = false.obs;

  // Getters
  List<UserModel> get users => _filteredUsers;
  bool get isLoading => _isLoading.value;
  String get searchQuery => _searchQuery.value;
  String get selectedRole => _selectedRole.value;
  bool get showActiveOnly => _showActiveOnly.value;

  List<String> get availableRoles => ['All', 'Admin', 'User'];
  int get totalUsers => _allUsers.length;
  int get activeUsers => _allUsers.where((u) => u.isActive).length;
  int get inactiveUsers => _allUsers.where((u) => !u.isActive).length;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// Kullanıcıları getir
  Future<void> fetchUsers() async {
    try {
      _isLoading.value = true;
      final users = await _repository.getUsers();
      _allUsers.value = users;
      _applyFilters();
    } catch (e) {
      Get.snackbar('Hata', 'Kullanıcılar yüklenemedi: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Arama
  void search(String query) {
    _searchQuery.value = query.toLowerCase();
    _applyFilters();
  }

  /// Role filtresi
  void filterByRole(String role) {
    _selectedRole.value = role;
    _applyFilters();
  }

  /// Aktif/Pasif filtresi
  void toggleActiveFilter(bool value) {
    _showActiveOnly.value = value;
    _applyFilters();
  }

  /// Tüm filtreleri uygula
  void _applyFilters() {
    var filtered = _allUsers.toList();

    // Arama filtresi
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.value) ||
            user.email.toLowerCase().contains(_searchQuery.value);
      }).toList();
    }

    // Role filtresi
    if (_selectedRole.value != 'All') {
      filtered = filtered
          .where((user) => user.role == _selectedRole.value)
          .toList();
    }

    // Aktif filtresi
    if (_showActiveOnly.value) {
      filtered = filtered.where((user) => user.isActive).toList();
    }

    _filteredUsers.value = filtered;
  }

  /// Kullanıcı durumu değiştir
  Future<void> toggleUserStatus(UserModel user) async {
    try {
      final updatedUser = user.copyWith(isActive: !user.isActive);
      final success = await _repository.updateUser(updatedUser);

      if (success) {
        final index = _allUsers.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          _allUsers[index] = updatedUser;
          _applyFilters();
        }
        Get.snackbar('Başarılı', 'Kullanıcı durumu güncellendi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Durum güncellenemedi: $e');
    }
  }

  /// Kullanıcı sil
  Future<void> deleteUser(int id) async {
    try {
      final success = await _repository.deleteUser(id);

      if (success) {
        _allUsers.removeWhere((u) => u.id == id);
        _applyFilters();
        Get.snackbar('Başarılı', 'Kullanıcı silindi');
      }
    } catch (e) {
      Get.snackbar('Hata', 'Kullanıcı silinemedi: $e');
    }
  }

  /// Filtreleri temizle
  void clearFilters() {
    _searchQuery.value = '';
    _selectedRole.value = 'All';
    _showActiveOnly.value = false;
    _applyFilters();
  }
}
