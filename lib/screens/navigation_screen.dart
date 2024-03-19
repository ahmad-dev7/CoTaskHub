import 'package:co_task_hub/components/drawer.dart';
import 'package:co_task_hub/constants/k_bottom_bar_items.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/screens/chat_screen.dart';
import 'package:co_task_hub/screens/files_screen.dart';
import 'package:co_task_hub/screens/home_screen.dart';
import 'package:co_task_hub/screens/track_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:toast/toast.dart';

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
    ToastContext().init(context);
    var teamData = myController.teamData.value;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: accentColor),
        title: ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(myController.teamData.value.teamName!),
          subtitle: Text(myController.teamData.value.projectName!),
        ),
        actions: [
          Visibility(
            visible: isAdmin,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Chip(
                backgroundColor: accentColor,
                label: KMyText(teamData.teamCode!, color: Colors.white),
                onDeleted: () => Clipboard.setData(
                  ClipboardData(text: teamData.teamCode!),
                ).then((value) => Toast.show(
                      'Team code copied to clipboard.',
                      duration: Toast.lengthShort,
                      gravity: Toast.center,
                    )),
                deleteIcon: const Icon(Icons.copy_rounded, color: Colors.white),
              ),
            ),
          )
        ],
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
