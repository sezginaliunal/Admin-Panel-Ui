// lib/app/features/finance/dialogs/add_transaction_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_project/app/features/dashboard/core/config/constants/colors/app_colors.dart';
import 'package:test_project/app/features/finance/finance_controller.dart';
import 'package:test_project/app/features/finance/models/transaction_model.dart';

class AddTransactionDialog extends StatefulWidget {
  final bool isIncome;
  final int? safeId;

  const AddTransactionDialog({super.key, required this.isIncome, this.safeId});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _referenceController = TextEditingController();

  late int _selectedSafeId;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<FinanceController>();
    _selectedSafeId = widget.safeId ?? controller.activeSafes.first.id;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FinanceController>();

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
                        color: widget.isIncome
                            ? AppColors.success(context).withOpacity(0.1)
                            : AppColors.error(context).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.isIncome
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: widget.isIncome
                            ? AppColors.success(context)
                            : AppColors.error(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.isIncome ? 'Gelir Ekle' : 'Gider Ekle',
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

                // Safe Selection
                DropdownButtonFormField<int>(
                  initialValue: _selectedSafeId,
                  decoration: InputDecoration(
                    labelText: 'Kasa *',
                    prefixIcon: const Icon(Icons.account_balance_wallet),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: controller.activeSafes.map((safe) {
                    return DropdownMenuItem(
                      value: safe.id,
                      child: Text('${safe.name} (${safe.currency})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedSafeId = value);
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Kasa seçimi gerekli';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Amount Field
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tutar *',
                    hintText: '0.00',
                    prefixIcon: Icon(
                      widget.isIncome ? Icons.add_circle : Icons.remove_circle,
                      color: widget.isIncome
                          ? AppColors.success(context)
                          : AppColors.error(context),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tutar gerekli';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Geçerli bir sayı girin';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Tutar 0\'dan büyük olmalı';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Açıklama *',
                    hintText: widget.isIncome
                        ? 'Örn: Satış geliri'
                        : 'Örn: Kira ödemesi',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Açıklama gerekli';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Category Field
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    hintText: widget.isIncome
                        ? 'Örn: Satış'
                        : 'Örn: Genel Giderler',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Reference Field
                TextFormField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                    labelText: 'Referans No',
                    hintText: 'Örn: FTR-2024-001',
                    prefixIcon: const Icon(Icons.receipt),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Date Picker
                InkWell(
                  onTap: _selectDate,
                  borderRadius: BorderRadius.circular(12),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Tarih *',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      DateFormat('dd MMMM yyyy').format(_selectedDate),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
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
                          backgroundColor: widget.isIncome
                              ? AppColors.success(context)
                              : AppColors.error(context),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.isIncome ? 'Gelir Ekle' : 'Gider Ekle',
                          style: const TextStyle(color: Colors.white),
                        ),
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

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<FinanceController>();

      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch,
        safeId: _selectedSafeId,
        type: widget.isIncome
            ? TransactionType.income
            : TransactionType.expense,
        amount: double.parse(_amountController.text),
        description: _descriptionController.text.trim(),
        category: _categoryController.text.trim().isEmpty
            ? null
            : _categoryController.text.trim(),
        referenceNo: _referenceController.text.trim().isEmpty
            ? null
            : _referenceController.text.trim(),
        date: _selectedDate,
        createdAt: DateTime.now(),
      );

      controller.createTransaction(transaction);
    }
  }
}
