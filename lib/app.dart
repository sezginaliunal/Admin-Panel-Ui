import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/app/app_infos.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/app/app_keys.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/routes/navigation_route_pages.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/routes/navigation_routes.dart';
import 'package:test_project/app/features/dashboard/core/theme/theme_controller.dart';
import 'package:test_project/core/localization/app_translations.dart';
import 'package:test_project/core/localization/language_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return Obx(() {
      if (!languageController.isLoaded) {
        return const SizedBox(); // splash / loader koyabilirsin
      }

      return GetMaterialApp(
        title: AppInfos.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: AppKeys().navigatorKey,
        getPages: AppRouter().getPages(),
        theme: themeController.state.themeData,
        initialRoute: RoutesName.dashboard.path,
        translations: AppTranslations(),
        locale: languageController.state.locale,
        fallbackLocale: const Locale('tr', 'TR'),
      );
    });
  }
}
