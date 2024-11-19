import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatelessWidget {
  BottomBar({
    super.key,
    required this.onTabChange,
    required this.backgroundColor,
    required this.color,
    required this.activeColor,
    required this.tabs,
  });

  final void Function(int)? onTabChange;
  final Color backgroundColor;
  final Color color;
  final Color activeColor;
  final List<BottomBarTab> tabs;

  @override
  Widget build(BuildContext context) {
    return GNav(
      backgroundColor: backgroundColor,
      color: color,
      activeColor: activeColor,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      onTabChange: (value) => onTabChange!(value),
      tabs: tabs.map((tab) {
        return GButton(
          icon: tab.icon,
          gap: 5,
          text: tab.text,
        );
      }).toList(),
    );
  }
}

class BottomBarTab {
  BottomBarTab({required this.icon, required this.text});

  final IconData icon;
  final String text;
}
