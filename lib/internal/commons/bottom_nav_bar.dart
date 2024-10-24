import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/theme_helper.dart';

class BottomNavBar extends StatefulWidget {
  final Widget child;

  const BottomNavBar({super.key, required this.child});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedTab = 0;

  final List<String> _routes = [
    '/',
    '/calendar',
    '/qr_scanner',
    // '/services',
    '/profile',
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });

    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: widget.child,
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: ThemeHelper.white,
        ),
        child: Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide.none,
              horizontal: BorderSide(color: Colors.white, width: 0.2),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedTab,
            onTap: (index) => _changeTab(index),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/home_icon.jpg',
                  width: 35,
                  height: 35,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/calendar_icon.jpg',
                  width: 35,
                  height: 35,
                ),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/qr_icon.jpg',
                  width: 40,
                  height: 35,
                ),
                label: 'Qr',
              ),
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //     'assets/images/services_icon.jpg',
              //     width: 30,
              //     height: 30,
              //   ),
              //   label: 'Services',
              // ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/profile_icons.jpg',
                  width: 35,
                  height: 35,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
