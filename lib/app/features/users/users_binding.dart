// lib/app/features/users/users_binding.dart
import 'package:get/get.dart';
import 'package:test_project/app/features/users/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(() => UsersController());
  }
}
