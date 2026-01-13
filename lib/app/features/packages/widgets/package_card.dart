import 'package:flutter/material.dart';
import 'package:test_project/app/core/helper/color_hex.dart';
import 'package:test_project/app/features/packages/models/package_model.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: package.isPopular
              ? AppColors.primary(context).withOpacity(0.4)
              : AppColors.cardBorder(context),
          width: package.isPopular ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow(context),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// BAŞLIK & ETİKET
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: hexToColor(package.color),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: hexToColor(package.color).withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface(context),
                          height: 1.2,
                        ),
                      ),
                      if (package.isPopular) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary(context).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primary(
                                context,
                              ).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Popüler Seçim',
                            style: TextStyle(
                              color: AppColors.primary(context),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// AÇIKLAMA
            Text(
              package.description,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant(context),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            /// FİYAT
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '₺${package.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary(context),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '/ ${package.duration}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ÖZELLİKLER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant(context).withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.outline(context).withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paket İçeriği',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface(context).withOpacity(0.8),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...package.features.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 18,
                            color: AppColors.success(context),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.onSurfaceVariant(context),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
