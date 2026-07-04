import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorManager.primary, 
                  Colors.white, 
                ],
              ),
            ),
          ),
          Positioned(
            top: 120.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Text("Welcome!",
                  textAlign: TextAlign.center,
                  
                  
                  style: getMedium500Style20(color: ColorManager.textPrimary,fontSize: 42.sp,fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 15.h,),
                Center(
                  child: Text("Your Trusted Physio Therapy App",
                  textAlign: TextAlign.center,
                  
                  
                  style: getMedium500Style20(color: ColorManager.backgroundDark.withValues(alpha: .6),fontSize: 18.sp),),
                ),
                
              ],
            )),
        
          Positioned(
            bottom: 0,
            child: Center(
              child: Container(
             
               
                child: Image.asset(
                  ImageManager.vector,
                  width: 1.sw, 
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

        
          Positioned(
            bottom: 50.r,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Image.asset(
                    ImageManager.splash,
                    width: 150.w,
                    height: 150.h,
                  ),
                  
                  SizedBox(height: 150.h), 
                  
                Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RoutesName.singInUpScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98D14F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Image.asset(IconManager.arrowRight,height: 16.h,width: 16.w,)
                    ],
                  ),
                ),
              ),
            ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}