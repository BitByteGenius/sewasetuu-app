import 'package:get/get.dart';

/// Notification model representing local or push notifications.
class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;
  final String? type;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.type,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}

/// Notification service handling push triggers and in-app alerts.
class NotificationService extends GetxService {
  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockNotifications();
  }

  void _loadMockNotifications() {
    notifications.assignAll([
      AppNotification(
        id: '1',
        title: 'Booking Confirmed! 🎉',
        body: 'Your stay at Pine View Homestay, Shillong has been confirmed for Sep 12-15.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        type: 'stay_booking',
      ),
      AppNotification(
        id: '2',
        title: 'Special 20% Discount Available',
        body: 'Book verified PGs & Rooms in Guwahati with no brokerage fees today.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        type: 'promotion',
      ),
      AppNotification(
        id: '3',
        title: 'Welcome to SewaSetu!',
        body: 'Explore rooms, PGs, mess, homestays, and upcoming local on-demand services.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
        type: 'welcome',
      ),
    ]);
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  void markAllAsRead() {
    notifications.assignAll(
      notifications.map((n) => n.copyWith(isRead: true)).toList(),
    );
  }
}
