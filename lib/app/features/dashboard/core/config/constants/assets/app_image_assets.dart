import 'package:test_project/app/features/dashboard/core/config/constants/app/app_infos.dart';

enum AppImageAssets {
  logo('logo.png'),
  background('background.jpg'),
  avatarPlaceholder('avatar_placeholder.png');

  const AppImageAssets(this.fileName);

  final String fileName;

  String get path => '${AppInfos.imagesBase}$fileName';
}
