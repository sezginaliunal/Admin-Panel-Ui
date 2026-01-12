import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/app/app_locale_keys.dart';
import 'package:test_project/app/features/dashboard/core/widgets/layout/admin_layout.dart';
import 'package:test_project/app/features/settings/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      child: ListView(
        children: [
          SwitchListTile(
            title: Text(AppLocaleKeys.appDarkMode.tr),
            value: context.isDarkMode ? true : false,
            onChanged: (val) => controller.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
