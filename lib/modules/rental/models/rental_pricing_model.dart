/// Transparent breakdown of rental costs, add-ons, taxes, discounts, and deposits.
class RentalPricingModel {
  final double basePricePerDay;
  final int durationDays;
  final int durationHours;
  final double rentalCost;
  final double addonCost;
  final double deliveryFee;
  final double taxRate; // e.g. 0.18 for 18% GST
  final double taxAmount;
  final double discountAmount;
  final String? couponCode;
  final double securityDeposit;
  final double totalPayable;
  final double refundableDeposit;

  const RentalPricingModel({
    required this.basePricePerDay,
    required this.durationDays,
    this.durationHours = 24,
    required this.rentalCost,
    this.addonCost = 0.0,
    this.deliveryFee = 0.0,
    this.taxRate = 0.18,
    required this.taxAmount,
    this.discountAmount = 0.0,
    this.couponCode,
    this.securityDeposit = 0.0,
    required this.totalPayable,
    this.refundableDeposit = 0.0,
  });

  /// Factory helper that computes all values given inputs.
  factory RentalPricingModel.calculate({
    required double basePricePerDay,
    required int durationDays,
    int durationHours = 24,
    double addonCost = 0.0,
    double deliveryFee = 0.0,
    double taxRate = 0.18,
    double discountAmount = 0.0,
    String? couponCode,
    double securityDeposit = 0.0,
  }) {
    final effectiveDays = durationDays > 0 ? durationDays : 1;
    final rentalCost = basePricePerDay * effectiveDays;
    final subtotal = rentalCost + addonCost + deliveryFee - discountAmount;
    final taxableAmount = subtotal > 0 ? subtotal : 0.0;
    final taxAmount = (taxableAmount * taxRate);
    final totalPayable = taxableAmount + taxAmount + securityDeposit;

    return RentalPricingModel(
      basePricePerDay: basePricePerDay,
      durationDays: effectiveDays,
      durationHours: durationHours,
      rentalCost: rentalCost,
      addonCost: addonCost,
      deliveryFee: deliveryFee,
      taxRate: taxRate,
      taxAmount: double.parse(taxAmount.toStringAsFixed(2)),
      discountAmount: discountAmount,
      couponCode: couponCode,
      securityDeposit: securityDeposit,
      totalPayable: double.parse(totalPayable.toStringAsFixed(2)),
      refundableDeposit: securityDeposit,
    );
  }

  RentalPricingModel copyWith({
    double? basePricePerDay,
    int? durationDays,
    int? durationHours,
    double? rentalCost,
    double? addonCost,
    double? deliveryFee,
    double? taxRate,
    double? taxAmount,
    double? discountAmount,
    String? couponCode,
    double? securityDeposit,
    double? totalPayable,
    double? refundableDeposit,
  }) {
    return RentalPricingModel(
      basePricePerDay: basePricePerDay ?? this.basePricePerDay,
      durationDays: durationDays ?? this.durationDays,
      durationHours: durationHours ?? this.durationHours,
      rentalCost: rentalCost ?? this.rentalCost,
      addonCost: addonCost ?? this.addonCost,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      couponCode: couponCode ?? this.couponCode,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      totalPayable: totalPayable ?? this.totalPayable,
      refundableDeposit: refundableDeposit ?? this.refundableDeposit,
    );
  }

  factory RentalPricingModel.fromJson(Map<String, dynamic> json) {
    return RentalPricingModel(
      basePricePerDay: (json['basePricePerDay'] as num?)?.toDouble() ?? 0.0,
      durationDays: json['durationDays'] as int? ?? 1,
      durationHours: json['durationHours'] as int? ?? 24,
      rentalCost: (json['rentalCost'] as num?)?.toDouble() ?? 0.0,
      addonCost: (json['addonCost'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.18,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      couponCode: json['couponCode'] as String?,
      securityDeposit: (json['securityDeposit'] as num?)?.toDouble() ?? 0.0,
      totalPayable: (json['totalPayable'] as num?)?.toDouble() ?? 0.0,
      refundableDeposit: (json['refundableDeposit'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basePricePerDay': basePricePerDay,
      'durationDays': durationDays,
      'durationHours': durationHours,
      'rentalCost': rentalCost,
      'addonCost': addonCost,
      'deliveryFee': deliveryFee,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'discountAmount': discountAmount,
      'couponCode': couponCode,
      'securityDeposit': securityDeposit,
      'totalPayable': totalPayable,
      'refundableDeposit': refundableDeposit,
    };
  }
}
