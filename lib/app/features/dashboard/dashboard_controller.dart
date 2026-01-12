import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/widgets/stat_card_model.dart';

class DashboardController extends GetxController {
  final RxList<StatCardModel> stats = <StatCardModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    loadStats();
    super.onReady();
  }

  Future<void> loadStats() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(milliseconds: 500));

      stats.assignAll([
        StatCardModel(
          id: '1',
          title: 'Toplam Kullanıcı',
          value: '2,543',
          icon: Icons.people_outline,
          accentColor: const Color(0xFF3B82F6),
          trend: 12.5,
          trendLabel: 'bu ay',
        ),
        StatCardModel(
          id: '2',
          title: 'Satış Sayısı',
          value: '1,234',
          icon: Icons.online_prediction_outlined,
          accentColor: const Color(0xFF10B981),
          trend: 8.2,
          trendLabel: 'şu an',
        ),
        StatCardModel(
          id: '3',
          title: 'Toplam Gelir',
          value: '₺45,231',
          icon: Icons.attach_money,
          accentColor: const Color(0xFF8B5CF6),
          trend: -2.4,
          trendLabel: 'bu hafta',
        ),
        StatCardModel(
          id: '4',
          title: 'Yeni Siparişler',
          value: '892',
          icon: Icons.shopping_cart_outlined,
          accentColor: const Color(0xFFF59E0B),
          subtitle: 'Beklemede: 42',
        ),
        StatCardModel(
          id: '5',
          title: 'Müşteri Memnuniyeti',
          value: '98.5%',
          icon: Icons.sentiment_satisfied_alt,
          accentColor: const Color(0xFFEC4899),
          trend: 1.2,
          trendLabel: 'geçen aya göre',
        ),
        StatCardModel(
          id: '6',
          title: 'Ortalama Sipariş',
          value: '₺234',
          icon: Icons.receipt_long_outlined,
          accentColor: const Color(0xFF06B6D4),
          trend: 5.8,
          trendLabel: 'artış',
        ),
      ]);
    } catch (e) {
      Get.snackbar(
        'Hata',
        'İstatistikler yüklenirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onStatCardTap(StatCardModel model) {
    Get.snackbar(
      model.title,
      'Detaylı görünüm: ${model.value}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
