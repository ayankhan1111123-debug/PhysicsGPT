import 'package:flutter/material.dart';

import '../../chat/screens/chat_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../tools/screens/tools_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ChatScreen(),
    ToolsScreen(),
    ProfileScreen(),
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: _pages[_selectedIndex],

    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: NavigationBar(
            height: 72,
            selectedIndex: _selectedIndex,
            backgroundColor: const Color(0xff161616),
            indicatorColor: Colors.white10,
            elevation: 0,
            labelBehavior:
                NavigationDestinationLabelBehavior.alwaysHide,
            animationDuration:
                const Duration(milliseconds: 350),
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: "Chat",
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: "Tools",
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}