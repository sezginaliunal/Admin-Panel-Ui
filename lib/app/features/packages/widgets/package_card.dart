import 'package:clara/extensions/context_extension.dart';
import 'package:clara/my_package.dart';
import 'package:flutter/material.dart';
import 'package:test_project/app/core/helper/color_hex.dart';
import 'package:test_project/app/features/packages/models/package_model.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: context.textStyles.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// AÇIKLAMA
            Text(package.description, style: context.textStyles.titleSmall),

            /// FİYAT
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                Text(
                  '${package.price.toCurrencyString(locale: 'tr_TR', symbol: '₺')}',
                  style: context.textStyles.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/ ${package.duration}',
                  style: context.textStyles.labelLarge,
                ),
              ],
            ),

            /// ÖZELLİKLER
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Paket İçeriği',
                      style: context.textStyles.labelLarge,
                    ),
                  ),
                  const Divider(height: 1),
                  ...package.features.map(
                    (feature) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.success(context),
                      ),
                      title: Text(feature),
                    ),
                  ),
                ],
              ).paddingNormal(),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Düzenle'),
              icon: Icon(Icons.edit),
            ).center,
          ],
        ),
      ).paddingNormal(),
    );
  }
}
