// lib/app/features/finance/dialogs/edit_safe_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/finance/finance_controller.dart';
import 'package:test_project/app/finance/models/safe_model.dart';

class EditSafeDialog extends StatefulWidget {
  final SafeModel safe;

  const EditSafeDialog({super.key, required this.safe});

  @override
  State<EditSafeDialog> createState() => _EditSafeDialogState();
}

class _EditSafeDialogState extends State<EditSafeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  late String _selectedCurrency;
  late bool _isActive;

  final List<String> _currencies = ['TRY', 'USD', 'EUR', 'GBP'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.safe.name);
    _descriptionController = TextEditingController(
      text: widget.safe.description ?? '',
    );
    _selectedCurrency = widget.safe.currency;
    _isActive = widget.safe.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary(context).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.primary(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Kasa Düzenle',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Info Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info(context).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.info(context).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: AppColors.info(context),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Mevcut bakiye: ${Get.find<FinanceController>().formatCurrency(widget.safe.balance, widget.safe.currency)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.info(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Kasa Adı *',
                    prefixIcon: const Icon(Icons.label),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kasa adı gerekli';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Currency Field (Disabled)
                DropdownButtonFormField<String>(
                  initialValue: _selectedCurrency,
                  decoration: InputDecoration(
                    labelText: 'Para Birimi',
                    prefixIcon: const Icon(Icons.monetization_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabled: false,
                  ),
                  items: _currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(_getCurrencyDisplay(currency)),
                    );
                  }).toList(),
                  onChanged: null,
                ),

                const SizedBox(height: 16),

                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    hintText: 'Kasa hakkında detaylar...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Active Switch
                SwitchListTile(
                  value: _isActive,
                  onChanged: (value) => setState(() => _isActive = value),
                  title: const Text('Aktif'),
                  subtitle: Text(
                    _isActive ? 'Kasa aktif' : 'Kasa pasif',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant(context),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('İptal'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Güncelle'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<FinanceController>();

      final updatedSafe = widget.safe.copyWith(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        isActive: _isActive,
        updatedAt: DateTime.now(),
      );

      controller.updateSafe(updatedSafe);
    }
  }

  String _getCurrencyDisplay(String currency) {
    switch (currency) {
      case 'TRY':
        return '₺ Türk Lirası';
      case 'USD':
        return '\$ Amerikan Doları';
      case 'EUR':
        return '€ Euro';
      case 'GBP':
        return '£ İngiliz Sterlini';
      default:
        return currency;
    }
  }
}
