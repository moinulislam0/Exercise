import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/utils.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/remaining_progress/remaining_progress_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/suggestion_video/suggestion_video_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_widget/workout_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.onOpenDrawer});

  final VoidCallback? onOpenDrawer;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _formatLevel(String? level) {
    if (level == null || level.isEmpty) return 'Beginner';
    final normalized = level.toLowerCase();
    return normalized[0].toUpperCase() + normalized.substring(1);
  }

  @override
  void initState() {
   Future.microtask((){
    ref.read(suggestedNotifierProvider.notifier).getSuggested();
    ref.read(getPrescriptionResumeProvider.notifier).getPrescription();
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final suggested = ref.watch(suggestedNotifierProvider);
    final suggestedList = suggested.suggestedData?.data ??[];
    final state = ref.watch(getMeProvider);
    final user = state.me?.data;
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: CustomeAppBarHome(
              onProfileTap: widget.onOpenDrawer,
              name: user?.name,
              email: user?.email,
              avatarUrl: user?.avatarUrl ?? user?.avatar,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(suggestedNotifierProvider.notifier).getSuggested();
          await ref.read(getPrescriptionResumeProvider.notifier).getPrescription();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RemainingProgressWidget(),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Your Prescribed Video",
                  style: getMedium500Style12(
                    color: ColorManager.subtextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(16.r), child: WorkoutWidget()),
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  border: Border.all(
                            color: ColorManager.subtextColorGrey,width: .2
                          ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      // Container(
                      //   height: 3.h,
                      //   width: 80.w,
                      //   decoration: BoxDecoration(
                      //     color: ColorManager.hintTextColor,
                      //     borderRadius: BorderRadius.circular(30.r),
                          
                      //   ),
                      // ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Suggested Videos",
                            style: getMedium500Style16(
                              color: ColorManager.subtextColor,
                              fontSize: 18.sp,
                            ),
                          ),
                          // Text(
                          //   "View All",
                          //   style: getMedium500Style12(
                          //     color: ColorManager.subtextColor,
                          //     fontSize: 14.sp,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      if (suggested.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (suggested.errorMessage != null)
                        Center(
                          child: Text(
                            suggested.errorMessage!,
                            textAlign: TextAlign.center,
                            style: getMedium500Style12(
                              color: ColorManager.subtextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      else if (suggestedList.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: suggestedList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 15.h,
                            mainAxisExtent: 190.h,
                          ),
                          itemBuilder: (context, index) {
                            final video = suggestedList[index];
                            return SuggestionVideoWidget(
                              id: video.id,
                              categoryName: video.category ?? "",
                              title: video.title ?? "No Title",
                              duration: Utils.formatDurationLabel(video.duration),
                              level: _formatLevel(video.level),
                              isBookmarked: video.isFavorite ?? false,
                            
                             
                              imageUrl:
                                  video.thumbnailUrl ?? ImageManager.gymGuide,
                              onPlayTap: () {
                                debugPrint("Playing: ${video.title}");
                                Navigator.pushNamed(context, RoutesName.prescibedDetailsScreen,arguments: {
              'id': video.id,
            },);
                              },
                            );
                          },
                        ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
         
            ],
          ),
        ),
      ),
    );
  }
}
