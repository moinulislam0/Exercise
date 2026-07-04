import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';

class PlayListScreenWidget extends ConsumerWidget {
  final String? id;
  final String? image;
  final String? videoCount;
  final String? title;
  final String? videoDuration;
  final String? totalTime;
  final String? buttonText, sufImage, bookMarkIcon;
  final VoidCallback? onTap;
  final Future<void> Function()? onBookmarkTap;
  final Color? buttonIconColor, colorbg;
  final Color? bookmarkIconColor;
  final bool isBookmarked;
  final bool enableBookmarkTap;

  const PlayListScreenWidget({
    super.key,
    this.id,
    this.image,
    this.videoCount,
    this.title,
    this.videoDuration,
    this.totalTime,
    this.buttonText,
    this.onTap,
    this.buttonIconColor,
    this.sufImage,
    this.colorbg,
    this.bookMarkIcon,
    this.onBookmarkTap,
    this.bookmarkIconColor,
    this.isBookmarked = false,
    this.enableBookmarkTap = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colorbg?? ColorManager.playlistBox,
          border: Border.all(
            color: const Color.fromARGB(255, 195, 195, 195),
            width: .8.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: _buildImage(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   videoCount ?? "",
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: getMedium500Style10(
                              //     color: ColorManager.subtextColorGrey,
                              //     fontSize: 14.sp,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                              // SizedBox(height: 8.h),
                              Text(
                                title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: getMedium500Style16(
                                  color: ColorManager.textPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    IconManager.videoICon,
                                    height: 13.h,
                                    width: 11.w,
                                    color: ColorManager.blackColor,
                                  ),
                                  SizedBox(width: 6.w),
                                  Flexible(
                                    child: Text(
                                      videoDuration ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getMedium500Style12(
                                        color: ColorManager.textPrimary,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  IconManager.clock,
                                  height: 13.h,
                                  color: ColorManager.blackColor,
                                ),
                                SizedBox(width: 5.w),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 70.w),
                                  child: Text(
                                    totalTime ?? "",
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: getMedium500Style12(
                                      color: ColorManager.textPrimary,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
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
                                            const SnackBar(
                                              content: Text("Failed To add Favourite"),
                                            ),
                                          );
                                        }
                                      }
                                    },
                              child: Opacity(
                                opacity:
                                    !enableBookmarkTap || id == null || id!.isEmpty
                                        ? 0.5
                                        : 1,
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
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Customebutton(
                sufImage: sufImage,
                text: buttonText,
                onTap: onTap,
                sufImageColor: buttonIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    final imagePath = image ?? "";

    if (imagePath.isEmpty) {
      return _fallbackImage();
    }

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: 73.h,
        width: 81.w,
        errorBuilder: (_, __, ___) => _fallbackImage(),
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      height: 73.h,
      width: 81.w,
      errorBuilder: (_, __, ___) => _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    return Container(
      height: 73.h,
      width: 81.w,
      color: ColorManager.playlistBox,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: ColorManager.subtextColorGrey,
        size: 22.r,
      ),
    );
  }
}
