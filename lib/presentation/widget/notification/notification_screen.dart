import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/notification_screen/view/screen/notification_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/notification_screen/viewModel/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(notificationProvider.notifier).getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);
    final unreadCount = notificationState.unreadCount;
    final badgeLabel = unreadCount > 99 ? '99+' : '$unreadCount';

    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (contex) {
            return const NotificationScreen1();
          },
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            ImageManager.notification,
            height: 28.h,
            width: 28.w,
            fit: BoxFit.contain,
          ),
          if (unreadCount > 0)
            Positioned(
              top: -6.h,
              right: -8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                constraints: BoxConstraints(minWidth: 18.w, minHeight: 18.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE85D5D),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white, width: 1.4.w),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    badgeLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
