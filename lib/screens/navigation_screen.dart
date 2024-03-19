import 'package:co_task_hub/constants/k_bottom_bar_items.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/screens/chat_screen.dart';
import 'package:co_task_hub/screens/files_screen.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/track_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<SalomonBottomBarItem> items = [
    kGetBottomBarItems(
      icon: Icons.home_outlined,
      text: 'Home',
      activeIcon: Icons.home_filled,
    ),
    kGetBottomBarItems(
      icon: Icons.chat_outlined,
      text: 'Chat',
      activeIcon: Icons.chat,
    ),
    kGetBottomBarItems(
      icon: Icons.file_copy_outlined,
      text: 'Document',
      activeIcon: Icons.file_copy,
    ),
    kGetBottomBarItems(
      icon: Icons.manage_history_outlined,
      text: 'History',
      activeIcon: Icons.manage_history,
    ),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const FilesScreen(),
    const TrackProgressScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: KMyText('Hello, ${dataBox.get('name')}'),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}
