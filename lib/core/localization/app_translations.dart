import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'json_flattener.dart';

class AppTranslations extends Translations {
  static final Map<String, Map<String, String>> _keys = {};

  static Future<void> load() async {
    _keys['tr_TR'] = await _loadLang('assets/lang/tr.json');
    _keys['en_US'] = await _loadLang('assets/lang/en.json');
  }

  static Future<Map<String, String>> _loadLang(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    return flattenJson(jsonMap);
  }

  @override
  Map<String, Map<String, String>> get keys => _keys;
}
