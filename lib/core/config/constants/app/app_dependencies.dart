import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/core/theme/theme_controller.dart';

class AppDependencies {
  static Future<void> init() async {
    await Hive.initFlutter();

    _registerCompanyCaches();
  }

  static void _registerCompanyCaches() {}
}

/// Uygulama başlatma işlemlerini yöneten sınıf
///
/// Tüm bağımlılıkları ve kontrol cihazlarını
/// merkezi bir yerden yönetir
class AppInitializer {
  AppInitializer._();

  /// Uygulamanın tüm başlangıç işlemlerini gerçekleştirir
  static Future<void> initialize() async {
    await _initializeDependencies();
    _registerControllers();
  }

  /// Uygulama bağımlılıklarını başlatır
  static Future<void> _initializeDependencies() async {
    await AppDependencies.init();
  }

  /// Kalıcı kontrol cihazlarını kaydeder
  static void _registerControllers() {
    Get.put(ThemeController(), permanent: true);
  }
}
