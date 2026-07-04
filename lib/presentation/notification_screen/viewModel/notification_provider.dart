import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/service/notification_service.dart';
import 'package:touralie33_fo222668a7688/data/models/notification_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';

class NotificationState {
  final bool isloading;
  final String? errormessage;
  final List<Data> notifications;
  final List<String> seenNotificationIds;

  NotificationState({
    this.errormessage,
    required this.isloading,
    this.notifications = const <Data>[],
    this.seenNotificationIds = const <String>[],
  });

  int get unreadCount {
    if (notifications.isEmpty) return 0;
    return notifications
        .where((item) => item.id != null && !seenNotificationIds.contains(item.id))
        .length;
  }

  bool isRead(Data item) {
    final id = item.id;
    if (id == null || id.isEmpty) return true;
    return seenNotificationIds.contains(id);
  }

  NotificationState copyWith({
    bool? isloading,
    String? errormessage,
    List<Data>? notifications,
    List<String>? seenNotificationIds,
  }) {
    return NotificationState(
      isloading: isloading ?? this.isloading,
      errormessage: errormessage,
      notifications: notifications ?? this.notifications,
      seenNotificationIds: seenNotificationIds ?? this.seenNotificationIds,
    );
  }
}

class NotificationProvider extends StateNotifier<NotificationState> {
  NotificationProvider() : super(NotificationState(isloading: false)) {
    _subscription = NotificationService.notificationStream.listen(_handleIncoming);
    unawaited(getNotification());
  }

  late final StreamSubscription<Data> _subscription;

  Future<void> _loadSeenNotifications() async {
    final seenIds = await SharedPreferenceData.getSeenNotificationIds();
    state = state.copyWith(seenNotificationIds: seenIds);
  }

  Future<bool> getNotification() async {
    state = state.copyWith(isloading: true, errormessage: null);
    try {
      await _loadSeenNotifications();
      final notifications = await SharedPreferenceData.getStoredNotifications();
      state = state.copyWith(
        isloading: false,
        errormessage: null,
        notifications: notifications,
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        isloading: false,
        errormessage: 'Failed to load notifications',
      );
      return false;
    }
  }

  Future<void> markAllAsRead() async {
    final ids = state.notifications
        .map((item) => item.id)
        .whereType<String>()
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList();
    await SharedPreferenceData.setSeenNotificationIds(ids);
    state = state.copyWith(seenNotificationIds: ids);
  }

  Future<void> _handleIncoming(Data notification) async {
    final updated = <Data>[
      notification,
      ...state.notifications.where((item) => item.id != notification.id),
    ];
    await SharedPreferenceData.setStoredNotifications(updated);
    state = state.copyWith(
      notifications: updated,
      errormessage: null,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationProvider, NotificationState>((ref) {
  return NotificationProvider();
});
