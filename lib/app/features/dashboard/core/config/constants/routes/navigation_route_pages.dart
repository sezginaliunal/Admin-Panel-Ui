import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/dashboard_binding.dart';
import 'package:test_project/app/features/dashboard/dashboard_page.dart';

import 'package:test_project/app/features/dashboard/core/config/constants/routes/navigation_routes.dart';
import 'package:test_project/app/features/packages/packages_binding.dart';
import 'package:test_project/app/features/packages/packages_view.dart';
import 'package:test_project/app/features/settings/settings_binding.dart';
import 'package:test_project/app/features/settings/settings_view.dart';
import 'package:test_project/app/features/users/users_binding.dart';
import 'package:test_project/app/features/users/users_view.dart';
import 'package:test_project/app/features/finance/finance_binding.dart';
import 'package:test_project/app/features/finance/finance_view.dart';

class AppRouter {
  // Singleton instance
  factory AppRouter() => _instance;
  AppRouter._privateConstructor();
  static final AppRouter _instance = AppRouter._privateConstructor();

  // GetX'de sayfa rotaları
  List<GetPage<dynamic>> getPages() {
    return [
      GetPage(
        name: RoutesName.dashboard.path,
        page: DashboardPage.new,
        binding: DashboardBinding(), // Binding ekleyin
      ),
      GetPage(
        name: RoutesName.settings.path,
        page: SettingsView.new,

        binding: SettingsBinding(), // Binding ekleyin
      ),
      GetPage(
        name: RoutesName.packages.path,
        page: PackagesView.new,
        binding: PackagesBinding(), // Binding ekleyin
      ),
      GetPage(
        name: RoutesName.users.path,
        page: UsersView.new,
        binding: UsersBinding(), // Binding ekleyin
      ),
      // routes.dart içine ekle
      GetPage(
        name: RoutesName.finance.path,
        page: () => const FinanceView(),
        binding: FinanceBinding(),
      ),
    ];
  }
}
