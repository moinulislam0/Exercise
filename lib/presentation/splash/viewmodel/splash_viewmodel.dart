// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/route/routes_name.dart';

final splashProvider = NotifierProvider<SplashNotifier, void>(
  SplashNotifier.new,
);

class SplashNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<void> initialFunction(BuildContext context) async {
    //**************************initial all function call here******************
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, RoutesName.bottomNavRoute);
    });
  }
}
