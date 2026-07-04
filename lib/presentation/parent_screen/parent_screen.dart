import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/view/screen/favourite_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/view/screen/home_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/playlist/view/screen/playlist_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/profile_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/drawer/drawer_screen.dart';

final parentScreenIndexProvider = StateProvider<int>((ref) => 0);

class ParentScreen extends ConsumerStatefulWidget {
  const ParentScreen({super.key});

  @override
  ConsumerState<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends ConsumerState<ParentScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(getMeProvider.notifier).getMe());
  }

  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(parentScreenIndexProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final List<Widget> screens = [
      HomeScreen(
        onOpenDrawer: () => scaffoldKey.currentState?.openDrawer(),
      ),
      const PlaylistScreen(),
      const FavouriteScreen(),
     ProfileScreen(
          onOpenDrawer: () => scaffoldKey.currentState?.openDrawer(),
      ),
    ];
   final items = <({String icon, String label})>[
  (icon: IconManager.home, label: 'Home'),
  (icon: IconManager.playList, label: 'Prescribed'), 
  (icon: IconManager.favourite, label: 'Favourite'),
  (icon: IconManager.profile, label: 'Profile'),
];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorManager.primary,
      drawer: const DrawerScreen(),
      body: screens[selectIndex],
      bottomNavigationBar: SafeArea(
   minimum: const EdgeInsets.fromLTRB(16, 16, 16, 35), 
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1), 
      blurRadius: 10,                   
      offset:  Offset(0, 4),          
      spreadRadius: 0,                     
    ),
  ],
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFDCE8C9)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = selectIndex == index;

              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  ref.read(parentScreenIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 12 : 13,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.backgroundColorgreen
                        : ColorManager.backgroundColorgreen.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        item.icon,
                        width: 20,
                        color: isSelected?  Color(0xFF1E2D11) : const Color.fromARGB(255, 105, 165, 35),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color:  Color(0xFF1E2D11),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
