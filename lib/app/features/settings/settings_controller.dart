import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/theme/theme_controller.dart';
import 'package:test_project/core/localization/language_controller.dart';
import 'package:test_project/core/localization/app_language.dart';

class SettingsController extends GetxController {
  final _themeController = Get.find<ThemeController>();
  final _languageController = Get.find<LanguageController>();

  /// Tema değiştir
  void toggleTheme() {
    _themeController.toggleTheme();
  }

  /// Dil değiştir
  void changeLanguage(AppLanguage language) {
    _languageController.setLanguage(language);
  }
}
