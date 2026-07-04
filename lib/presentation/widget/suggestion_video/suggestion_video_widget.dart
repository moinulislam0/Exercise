import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';


class SuggestionVideoWidget extends ConsumerWidget {
  final String? id;
  final String categoryName;
  final String title;
  final String duration;
  final String level;
  final String imageUrl;


  final Color? colorBg;
  final Color? bookmarkIconColor;
  final bool isBookmarked;
  final bool enableBookmarkTap;
  final VoidCallback? onPlayTap;
  final Future<void> Function()? onBookmarkTap;

  const SuggestionVideoWidget({
    super.key,
    this.id,
    required this.categoryName,
    required this.title,
    required this.duration,
    required this.level,
    required this.imageUrl,
 
    
    this.onPlayTap,
    this.colorBg,
    this.bookmarkIconColor,
    this.isBookmarked = false,
    this.enableBookmarkTap = true,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnailHeight = 78.h;

    return InkWell(
      onTap: onPlayTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorBg ?? ColorManager.playlistBox,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: ColorManager.borderColor, width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: imageUrl.startsWith('http')
                        ? Image.network(
                            imageUrl,
                            height: thumbnailHeight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              imageUrl,
                              height: thumbnailHeight,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            imageUrl,
                            height: thumbnailHeight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  // Positioned(
                  //   left: 6.w,
                  //   bottom: 6.h,
                  //   child: Text(
                  //     progressText,
                  //     style: getMedium500Style12(
                  //       color: ColorManager.whiteColor,
                  //       fontSize: 14.sp,
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 0.w,
                  //   bottom: 0.h,
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  //     decoration: BoxDecoration(
                  //       color: ColorManager.backgroundColorgreen,
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(5.r),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Image.asset(IconManager.videoICon, height: 10.h),
                  //         SizedBox(width: 4.w),
                  //         Text(
                  //           videoCountText,
                  //           style: TextStyle(
                  //             color: ColorManager.subtextColor,
                  //             fontSize: 11.sp,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getMedium500Style10(
                        color: ColorManager.subtextColorGrey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: !enableBookmarkTap || id == null || id!.isEmpty
                        ? null
                        : () async {
                            if (onBookmarkTap != null) {
                              await onBookmarkTap!();
                              return;
                            }

                            try {
                              await ref
                                  .read(favouriteIdProvider.notifier)
                                  .favouriteId(id: id!);
                              ref
                                  .read(suggestedNotifierProvider.notifier)
                                  .markSuggestedAsFavourite(id!);
                              await ref
                                  .read(favouriteProvider.notifier)
                                  .getFavourite();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bookmark updated'),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Failed To add Favourite"),
                                  ),
                                );
                              }
                            }
                          },
                    child: Opacity(
                      opacity:
                          !enableBookmarkTap || id == null || id!.isEmpty ? 0.5 : 1,
                      child: Image.asset(
                        IconManager.bookMark,
                        height: 12.h,
                        color: bookmarkIconColor ??
                            (isBookmarked
                                ? ColorManager.blackColor
                                : ColorManager.subtextColorGrey),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getMedium500Style10(
                  color: ColorManager.subtextColor,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(IconManager.clock, height: 14.h, width: 14.w),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              duration,
                              maxLines: 1,
                              style: getMedium500Style10(
                                color: ColorManager.subtextColorGrey,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.r),
                        color: ColorManager.beginerColor,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          level,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getMedium500Style10(
                            color: ColorManager.textPrimary,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
