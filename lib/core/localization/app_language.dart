import 'package:flutter/material.dart';

enum AppLanguage { tr, en }

extension AppLanguageX on AppLanguage {
  Locale get locale {
    switch (this) {
      case AppLanguage.en:
        return const Locale('en', 'US');
      case AppLanguage.tr:
      default:
        return const Locale('tr', 'TR');
    }
  }
}
