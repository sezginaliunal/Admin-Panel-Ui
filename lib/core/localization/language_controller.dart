import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'language_state.dart';
import 'app_language.dart';

class LanguageController extends GetxController {
  final Rx<LanguageState> _state = const LanguageState(
    language: AppLanguage.tr,
    isLoaded: false,
  ).obs;

  LanguageState get state => _state.value;
  AppLanguage get language => _state.value.language;
  bool get isLoaded => _state.value.isLoaded;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  /// Hive'dan dili yükle
  Future<void> loadLanguage() async {
    final box = await Hive.openBox('language');
    final index = box.get('languageIndex', defaultValue: 0) as int;

    _state.value = LanguageState(
      language: AppLanguage.values[index],
      isLoaded: true,
    );
    print(language.name);
  }

  /// Dil değiştir
  Future<void> setLanguage(AppLanguage language) async {
    final box = Hive.box('language');
    await box.put('languageIndex', language.index);

    _state.value = state.copyWith(language: language);
    Get.updateLocale(language.locale);
    loadLanguage();
  }
}
