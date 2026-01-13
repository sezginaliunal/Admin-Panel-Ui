import 'package:get/state_manager.dart';
import 'package:test_project/app/features/packages/models/package_model.dart';

class PackagesController extends GetxController {
  final packages = <PackageModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPackages();
  }

  void loadPackages() {
    isLoading.value = true;

    // Örnek paketler
    packages.value = [
      PackageModel(
        id: '1',
        name: 'Başlangıç',
        description: 'Küçük işletmeler için ideal',
        price: 99,
        duration: 'Aylık',
        features: [
          '5 Kullanıcı',
          '10 GB Depolama',
          'Email Desteği',
          'Temel Raporlar',
        ],
      ),
      PackageModel(
        id: '2',
        name: 'Profesyonel',
        description: 'Büyüyen ekipler için',
        price: 299,
        duration: 'Aylık',
        features: [
          '20 Kullanıcı',
          '100 GB Depolama',
          'Öncelikli Destek',
          'Gelişmiş Raporlar',
        ],
      ),
      PackageModel(
        id: '3',
        name: 'Kurumsal',
        description: 'Büyük organizasyonlar için',
        price: 799,
        duration: 'Aylık',
        features: [
          'Sınırsız Kullanıcı',
          '1 TB Depolama',
          '7/24 Destek',
          'Özel Raporlar',
        ],
      ),
    ];

    isLoading.value = false;
  }
}
