import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/notification_screen/viewModel/notification_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/notification_widget/notification_widget.dart';

class NotificationScreen1 extends ConsumerStatefulWidget {
  const NotificationScreen1({super.key});

  @override
  ConsumerState<NotificationScreen1> createState() => _NotificationScreen1State();
}

class _NotificationScreen1State extends ConsumerState<NotificationScreen1> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(notificationProvider.notifier).getNotification();
    });
  }

  String _formatTime(String? createdAt) {
    if (createdAt == null || createdAt.trim().isEmpty) {
      return '';
    }

    final parsed = DateTime.tryParse(createdAt)?.toLocal();
    if (parsed == null) {
      return createdAt;
    }

    final now = DateTime.now();
    final difference = now.difference(parsed);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    }
    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    }
    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    return DateFormat('dd MMM yyyy').format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);
    final notifications = notificationState.notifications;

    Future.microtask(() {
      if (notifications.isNotEmpty && notificationState.unreadCount > 0) {
        ref.read(notificationProvider.notifier).markAllAsRead();
      }
    });

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.r),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 520.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "All Notification",
                style: getMedium500Style12(
                  color: ColorManager.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              if (notificationState.isloading)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                )
              else if (notificationState.errormessage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    notificationState.errormessage!,
                    textAlign: TextAlign.center,
                    style: getMedium500Style12(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else if (notifications.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    "No notification found",
                    textAlign: TextAlign.center,
                    style: getMedium500Style12(
                      color: ColorManager.blackColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: notifications.length,
                    separatorBuilder: (_, __) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Divider(
                        color: Color.fromARGB(255, 231, 230, 230),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      final isRead = notificationState.isRead(item);
                      return NotificationWidget(
                        time: _formatTime(item.createdAt),
                        title: item.title,
                        description: item.description,
                        isRead: isRead,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
