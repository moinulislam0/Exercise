import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/data/models/membership_model.dart';
import 'package:touralie33_fo222668a7688/presentation/subscription/view/widget/plan_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/subscription/viewModel/subscription_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(subscriptionProvider.notifier).subscription();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionState = ref.watch(subscriptionProvider);
    final membershipPlans = subscriptionState.membershipModel?.data ?? <Data>[];

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: "Clinic Packages!",
              ontap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.parentScreen,
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Image.asset(
                  IconManager.subscriptionIcon,
                  fit: BoxFit.cover,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Explore our physical",
                  style: getMedium500Style12(
                    color: ColorManager.textPrimary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "therapy services!", // Fixed typo
                  style: getMedium500Style12(
                    color: ColorManager.textPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Builder(
                  builder: (context) {
                    if (subscriptionState.isloading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (subscriptionState.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Text(
                            subscriptionState.errorMessage!,
                            textAlign: TextAlign.center,
                            style: getMedium500Style12(
                              color: Colors.red,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }

                    if (membershipPlans.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Text(
                            "No packages found",
                            textAlign: TextAlign.center,
                            style: getMedium500Style12(
                              color: ColorManager.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        ...membershipPlans.map<Widget>((plan) {
                          final formattedPrice = plan.price == null
                              ? ''
                              : '\$${plan.price!.toStringAsFixed(2)}${(plan.period ?? '').isEmpty ? '' : '/${plan.period}'}';
                          return PlanWidget(
                            title: plan.title,
                            price: formattedPrice,
                            description: plan.description,
                            featureHeader: plan.badge,
                            features: plan.features,
                            onSelect: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesName.getInTouchScreen,
                                arguments: {'id': plan.id, 'title': plan.title},
                              );
                            },
                          );
                        }),
                        SizedBox(height: 20.h),
                      ],
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
