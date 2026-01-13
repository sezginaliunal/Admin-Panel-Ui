import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/app/app_locale_keys.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'package:test_project/app/features/settings/settings_controller.dart';

import 'package:test_project/core/localization/app_language.dart';
import 'package:test_project/core/localization/language_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return AdminLayout(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tema Switch
          SwitchListTile(
            title: Text(AppLocaleKeys.appDarkMode.tr),
            value: context.isDarkMode,
            onChanged: (val) => controller.toggleTheme(),
          ),
          const SizedBox(height: 16),
          // Dil seçimi
          Obx(() {
            return DropdownButton<AppLanguage>(
              value: languageController.language,
              items: AppLanguage.values.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang == AppLanguage.tr ? 'Türkçe' : 'English'),
                );
              }).toList(),
              onChanged: (lang) {
                if (lang != null) {
                  controller.changeLanguage(lang);
                }
              },
            );
          }),
          Text(AppLocaleKeys.changePassword.tr),
        ],
      ),
    );
  }
}
