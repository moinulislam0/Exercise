import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/core/service/notification_service.dart';
import 'package:touralie33_fo222668a7688/data/repositories/auth_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/security_screen/view/security_screen.dart';

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getMeProvider);
    final user = state.me?.data;
    final resolvedAvatarUrl = _resolveAvatarUrl(
      user?.avatarUrl ?? user?.avatar,
    );

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.68,
      backgroundColor: ColorManager.drawrColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60.r * 2,
                  height: 60.r * 2,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: resolvedAvatarUrl != null
                      ? Image.network(
                          resolvedAvatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageManager.profilePic,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(ImageManager.profilePic, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  (user?.name != null && user!.name!.trim().isNotEmpty)
                      ? user.name!.trim()
                      : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  (user?.email != null && user!.email!.trim().isNotEmpty)
                      ? user.email!.trim()
                      : '',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .9),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 14.h),
              _DrawerItem(
                ontap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesName.subscriptionScreen,
                  );
                },
                icon: IconManager.subscriptionPlan,
                title: 'Clinic Plans',
              ),
              _DrawerItem(
                ontap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SecurityScreen()),
                  );
                },
                icon: IconManager.security,
                title: 'Security',
              ),
              _DrawerItem(
                ontap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesName.settingScreen,
                  );
                },
                icon: IconManager.setting,
                title: 'Settings',
              ),

              const Spacer(),
              _DrawerItem(
                ontap: () async {
                  try {
                    await AuthRepository(
                      remoteSource: AuthApiService(apiClient: ApiClient()),
                    ).logout();
                  } catch (_) {}
                  await NotificationService.clearTokenOnLogout();
                  await SharedPreferenceData.removeToken();

                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.signInScreen,
                      (route) => false,
                    );
                  }
                },
                icon: IconManager.logout,
                title: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? ontap;

  const _DrawerItem({required this.icon, required this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(10.r),
        child: Row(
          children: [
            Image.asset(icon, fit: BoxFit.cover, height: 16.h, width: 16.w),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
