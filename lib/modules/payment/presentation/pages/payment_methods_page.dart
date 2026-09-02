import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';

/// Payment methods management placeholder screen.
class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Methods',
          style: AppTextStyles.headlineSmall(isDark),
        ),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance_wallet_outlined),
                ),
                title: Text('Google Pay / PhonePe UPI', style: AppTextStyles.titleMedium(isDark)),
                subtitle: Text('Primary • user@okhdfcbank', style: AppTextStyles.bodySmall(isDark)),
                trailing: const Icon(Icons.check_circle_rounded, color: AppColors.primary),
              ),
            ),
            AppSpacing.gapV12,
            AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.credit_card_outlined),
                ),
                title: Text('HDFC Bank Visa Debit Card', style: AppTextStyles.titleMedium(isDark)),
                subtitle: Text('•••• 4920 (Expires 08/29)', style: AppTextStyles.bodySmall(isDark)),
                trailing: const Icon(Icons.more_vert_rounded),
              ),
            ),
            const Spacer(),
            AppButton.outline(
              text: '+ Add New Payment Method',
              width: double.infinity,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
