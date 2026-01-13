// lib/app/features/users/repositories/user_repository.dart
import 'package:test_project/app/features/dashboard/core/models/user_model.dart';

class UserRepository {
  // Mock data - gerçek projede API çağrısı yapılacak
  Future<List<UserModel>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500)); // API simülasyonu

    return List.generate(
      100,
      (i) => UserModel(
        id: i + 1,
        name: 'User ${i + 1}',
        email: 'user${i + 1}@mail.com',
        role: i.isEven ? 'Admin' : 'User',
        isActive: i.isEven,
      ),
    );
  }

  Future<UserModel?> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // API çağrısı simülasyonu
    return true;
  }

  Future<bool> deleteUser(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // API çağrısı simülasyonu
    return true;
  }

  Future<bool> createUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // API çağrısı simülasyonu
    return true;
  }
}
