import 'package:get/get.dart';
import 'dashboard_controller.dart';

/// Dashboard binding sınıfı
///
/// Dashboard sayfası için gerekli controller'ları enjekte eder
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
