import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app.dart';
import 'package:test_project/core/config/constants/app/app_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initialize();

  runApp(MyApp());
}
