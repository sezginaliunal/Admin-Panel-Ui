import 'package:flutter/material.dart';
import 'app_language.dart';

class LanguageState {
  final AppLanguage language;
  final bool isLoaded;

  const LanguageState({this.language = AppLanguage.tr, this.isLoaded = false});

  Locale get locale => language.locale;

  LanguageState copyWith({AppLanguage? language, bool? isLoaded}) {
    return LanguageState(
      language: language ?? this.language,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}
