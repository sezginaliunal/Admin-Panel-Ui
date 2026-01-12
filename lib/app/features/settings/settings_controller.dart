import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:test_project/app/features/dashboard/core/theme/theme_controller.dart';

class SettingsController extends GetxController {
  final _themeController = Get.find<ThemeController>();

  void toggleTheme() {
    _themeController.toggleTheme();
  }
}
