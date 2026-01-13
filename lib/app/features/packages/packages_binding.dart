import 'package:get/get.dart';
import 'package:test_project/app/features/packages/packages_controller.dart';

/// Dashboard binding sınıfı
///
/// Dashboard sayfası için gerekli controller'ları enjekte eder
class PackagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackagesController>(() => PackagesController());
  }
}
