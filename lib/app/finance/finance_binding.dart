// lib/app/features/finance/finance_binding.dart
import 'package:get/get.dart';
import 'package:test_project/app/finance/finance_controller.dart';

class FinanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinanceController>(() => FinanceController());
  }
}
