import 'package:flutter/material.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/widet/watch_history_list.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WatchHistoryList(showCompleted: true);
  }
}
