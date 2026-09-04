import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../controllers/checkout_controller.dart';
import '../models/address_model.dart';
import '../shop_navigator.dart';

/// Screen allowing the customer to enter and save a new delivery address
class AddAddressScreen extends StatefulWidget {
  final bool proceedDirectlyToCheckout;

  const AddAddressScreen({
    super.key,
    this.proceedDirectlyToCheckout = false,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _houseCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _landmarkCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();

  String _selectedType = 'Home';
  bool _isDefault = false;

  late final ShopCheckoutController _checkoutCtrl;

  @override
  void initState() {
    super.initState();
    _checkoutCtrl = Get.isRegistered<ShopCheckoutController>()
        ? Get.find<ShopCheckoutController>()
        : Get.put(ShopCheckoutController());

    // If no addresses exist, default this first one to true
    if (_checkoutCtrl.addresses.isEmpty) {
      _isDefault = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _pincodeCtrl.dispose();
    _houseCtrl.dispose();
    _streetCtrl.dispose();
    _landmarkCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    final fullStreet = '${_houseCtrl.text.trim()}, ${_streetCtrl.text.trim()}';

    final newAddress = ShopAddressModel(
      id: 'addr-${DateTime.now().millisecondsSinceEpoch}',
      fullName: _nameCtrl.text.trim(),
      phone: '+91 ${_phoneCtrl.text.trim()}',
      streetAddress: fullStreet,
      landmark: _landmarkCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      state: _stateCtrl.text.trim(),
      pincode: _pincodeCtrl.text.trim(),
      type: _selectedType,
      isDefault: _isDefault,
    );

    _checkoutCtrl.addAddress(newAddress);

    Get.snackbar(
      'Address Saved',
      'Your delivery address has been saved and selected.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withAlpha(200),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );

    if (widget.proceedDirectlyToCheckout) {
      ShopNavigator.toCheckout();
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add Delivery Address',
          style: AppTextStyles.titleMedium(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Information Header
              _buildSectionHeader(
                isDark: isDark,
                title: 'Contact Details',
                icon: Icons.person_outline_rounded,
              ),
              AppSpacing.gapV12,

              // Full Name
              AppTextField(
                controller: _nameCtrl,
                label: 'Full Name *',
                hint: 'e.g. Rahul Sharma',
                prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (val.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              // Mobile Number
              AppTextField(
                controller: _phoneCtrl,
                label: 'Mobile Number *',
                hint: '10-digit mobile number',
                keyboardType: TextInputType.phone,
                prefixIcon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  width: 60,
                  child: Text(
                    '+91',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter mobile number';
                  }
                  final cleaned = val.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cleaned.length != 10) {
                    return 'Please enter a valid 10-digit number';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV20,

              // Address Details Header
              _buildSectionHeader(
                isDark: isDark,
                title: 'Address Information',
                icon: Icons.location_on_outlined,
              ),
              AppSpacing.gapV12,

              // Pincode & City row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _pincodeCtrl,
                      label: 'Pincode *',
                      hint: '6-digit PIN',
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.pin_drop_outlined, size: 20),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter pincode';
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(val.trim())) {
                          return 'Enter 6 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      controller: _cityCtrl,
                      label: 'City / Town *',
                      hint: 'e.g. Guwahati',
                      prefixIcon: const Icon(Icons.location_city_outlined, size: 20),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Enter city';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              AppSpacing.gapV12,

              // State
              AppTextField(
                controller: _stateCtrl,
                label: 'State *',
                hint: 'e.g. Assam, Bihar, Rajasthan',
                prefixIcon: const Icon(Icons.map_outlined, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter state';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              // House / Flat / Building
              AppTextField(
                controller: _houseCtrl,
                label: 'Flat / House No. / Building *',
                hint: 'e.g. Flat 402, Block A',
                prefixIcon: const Icon(Icons.home_work_outlined, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter flat or house details';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              // Street / Area / Sector
              AppTextField(
                controller: _streetCtrl,
                label: 'Area / Street / Sector *',
                hint: 'e.g. Lachit Nagar, G.S. Road',
                prefixIcon: const Icon(Icons.signpost_outlined, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter street or area name';
                  }
                  return null;
                },
              ),
              AppSpacing.gapV12,

              // Landmark (Optional)
              AppTextField(
                controller: _landmarkCtrl,
                label: 'Landmark (Optional)',
                hint: 'e.g. Near Rajdhani Masjid',
                prefixIcon: const Icon(Icons.flag_outlined, size: 20),
              ),
              AppSpacing.gapV20,

              // Address Type Selector
              _buildSectionHeader(
                isDark: isDark,
                title: 'Address Type',
                icon: Icons.label_outline_rounded,
              ),
              AppSpacing.gapV12,
              Row(
                children: [
                  _buildTypeChip(
                    isDark: isDark,
                    type: 'Home',
                    icon: Icons.home_rounded,
                  ),
                  const SizedBox(width: 10),
                  _buildTypeChip(
                    isDark: isDark,
                    type: 'Work',
                    icon: Icons.business_rounded,
                  ),
                  const SizedBox(width: 10),
                  _buildTypeChip(
                    isDark: isDark,
                    type: 'Other',
                    icon: Icons.location_on_rounded,
                  ),
                ],
              ),
              AppSpacing.gapV20,

              // Default Address Checkbox
              AppCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isDefault,
                      activeColor: isDark
                          ? AppColors.primaryLight
                          : AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _isDefault = val ?? false;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make this my default delivery address',
                            style: AppTextStyles.bodyMedium(isDark).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'This address will be pre-selected for future shop orders',
                            style: AppTextStyles.bodySmall(isDark).copyWith(
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textMutedLight,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              AppButton.primary(
                text: 'Save & Use This Address',
                icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                width: double.infinity,
                onPressed: _saveAddress,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required bool isDark,
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark ? AppColors.primaryLight : AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.titleSmall(isDark).copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeChip({
    required bool isDark,
    required String type,
    required IconData icon,
  }) {
    final isSelected = _selectedType == type;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedType = type;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                    ? AppColors.primaryLight.withAlpha(40)
                    : AppColors.primary.withAlpha(25))
                : (isDark
                    ? AppColors.surfaceVariantDark.withAlpha(60)
                    : AppColors.surfaceVariantLight.withAlpha(70)),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? (isDark ? AppColors.primaryLight : AppColors.primary)
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    : (isDark
                        ? AppColors.textMutedDark
                        : AppColors.textMutedLight),
              ),
              const SizedBox(width: 6),
              Text(
                type,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected
                      ? (isDark ? AppColors.primaryLight : AppColors.primary)
                      : (isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
