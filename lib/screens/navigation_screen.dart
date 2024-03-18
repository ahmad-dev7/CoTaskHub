import 'package:co_task_hub/constants/k_nav_item.dart';
import 'package:co_task_hub/screens/chat_screen.dart';
import 'package:co_task_hub/screens/files_screen.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/track_screen.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<TabItem> tabItems = List.of([
    kGetTabItem(Icons.home, 'Home'),
    kGetTabItem(Icons.chat, 'Chat'),
    kGetTabItem(Icons.file_copy_sharp, 'Files'),
    kGetTabItem(Icons.manage_history, 'History'),
  ]);
  List<IconData> icons = [
    Icons.home,
    Icons.chat,
    Icons.folder,
    Icons.manage_history,
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const FilesScreen(),
    const TrackProgressScreen(),
  ];
  final CircularBottomNavigationController navController =
      CircularBottomNavigationController(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(),
      ),
      body: screens[navController.value!],
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        iconsSize: 30,
        circleSize: 50,
        circleStrokeWidth: 1,
        normalIconColor: Colors.white70,
        barBackgroundColor: const Color(0xFF5191B6),
        controller: navController,
        allowSelectedIconCallback: true,
        selectedCallback: (i) => setState(() => navController.value = i),
      ),
    );
  }
}
