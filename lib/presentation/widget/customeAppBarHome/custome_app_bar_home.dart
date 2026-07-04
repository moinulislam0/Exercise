import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/notification/notification_screen.dart';

class CustomeAppBarHome extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final String? name;
  final String? email;
  final String? avatarUrl;

  const CustomeAppBarHome({
    super.key,
    this.onProfileTap,
    this.name,
    this.email,
    this.avatarUrl,
  });

  String? _resolveAvatarUrl(String? avatar) {
    final value = avatar?.trim();
    if (value == null || value.isEmpty) return null;
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    final base = ApiEndpoints.baseUrl.endsWith('/')
        ? ApiEndpoints.baseUrl.substring(0, ApiEndpoints.baseUrl.length - 1)
        : ApiEndpoints.baseUrl;
    final path = value.startsWith('/') ? value : '/$value';
    return '$base$path';
  }

  @override
  Widget build(BuildContext context) {
    final resolvedAvatarUrl = _resolveAvatarUrl(avatarUrl);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
             GestureDetector(
              onTap: () {
                onProfileTap?.call();
              },
             child: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: resolvedAvatarUrl != null
                    ? Image.network(
                        resolvedAvatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "",
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        ImageManager.profilePic,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (name != null && name!.trim().isNotEmpty) ? name!.trim() : "Unknown Name",
                  style: getMedium500Style18(
                    color: ColorManager.subtextColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  (email != null && email!.trim().isNotEmpty)
                      ? email!.trim()
                      : "None",
                  style: getMedium500Style10(
                    color: const Color(0xFFA2A1A1), 
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
          ],
        ),

        NotificationScreen()
      ],
    );
  }
}
