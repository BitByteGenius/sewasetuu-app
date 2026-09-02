import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sewasetu/app/theme/app_colors.dart';
import 'package:sewasetu/app/theme/app_spacing.dart';
import 'package:sewasetu/app/theme/app_text_styles.dart';
import 'package:sewasetu/core/services/notification_service.dart';
import 'package:sewasetu/core/utils/formatters.dart';
import 'package:sewasetu/shared/widgets/app_card.dart';

/// Notifications feed screen.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notificationService = Get.find<NotificationService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.headlineSmall(isDark),
        ),
        actions: [
          TextButton(
            onPressed: notificationService.markAllAsRead,
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: Obx(() {
        final notifications = notificationService.notifications;
        if (notifications.isEmpty) {
          return const Center(child: Text('No notifications'));
        }

        return ListView.separated(
          padding: AppSpacing.screenPadding,
          itemCount: notifications.length,
          separatorBuilder: (context, index) => AppSpacing.gapV12,
          itemBuilder: (context, index) {
            final notif = notifications[index];
            return AppCard(
              padding: AppSpacing.edgeInsetsMd,
              backgroundColor: notif.isRead
                  ? null
                  : (isDark ? AppColors.surfaceVariantDark : AppColors.primaryContainer.withAlpha(80)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: 20,
                      color: isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                  AppSpacing.gapH12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.title,
                          style: AppTextStyles.titleMedium(isDark).copyWith(
                            fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.w800,
                          ),
                        ),
                        AppSpacing.gapV4,
                        Text(
                          notif.body,
                          style: AppTextStyles.bodyMedium(isDark),
                        ),
                        AppSpacing.gapV8,
                        Text(
                          AppFormatters.formatDate(notif.timestamp, 'hh:mm a, dd MMM'),
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
