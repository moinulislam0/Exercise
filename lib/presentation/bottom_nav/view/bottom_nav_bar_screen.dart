import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/resource/constants/color_manger.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  ConsumerState<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> {
  final List<Widget> _screenList = [
    Scaffold(body: Center(child: Text("Home"))),
    Scaffold(body: Center(child: Text("dangerous"))),
    Scaffold(body: Center(child: Text("search"))),
    Scaffold(body: Center(child: Text("settings"))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[ref.watch(bottomNavBarProvider)],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorManager.background,
        onTap: ref.read(bottomNavBarProvider.notifier).onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dangerous), label: "dangerous"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        ],
      ),
    );
  }
}

