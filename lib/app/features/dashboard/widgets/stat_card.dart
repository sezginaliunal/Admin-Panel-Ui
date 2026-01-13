import 'package:clara/my_package.dart';
import 'package:flutter/material.dart';
import 'package:test_project/app/features/dashboard/core/widgets/stat_card_model.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.model, this.onTap});

  final StatCardModel model;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor:
                model.accentColor?.withValues(alpha: 0.15) ??
                Colors.grey.withValues(alpha: 0.15),
            child: Icon(
              model.icon,
              color: model.accentColor ?? Colors.grey,
              size: 24,
            ),
          ),
          title: Text(model.title, style: context.textStyles.bodyLarge),
          isThreeLine: true,
          dense: true,
          subtitle: Text(
            model.value,
            style: context.textStyles.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ).center,
      ),
    );
  }
}
