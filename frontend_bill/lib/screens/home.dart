import 'package:flutter/material.dart';
import 'package:general/widget/bottom_bar.dart';
import 'package:general/widget/drawer.dart';
import 'package:general/screens/dashboard.dart';
import 'package:general/screens/chat.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ChatPage(),
    const Dashboard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BottomBar(
        onTabChange: (index) => navigateBottomBar(index),
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.onSurface,
        activeColor: Theme.of(context).colorScheme.onSurface,
        tabs: [
          BottomBarTab(icon: Icons.chat, text: AppLocalizations.of(context)!.chat),
          BottomBarTab(icon: Icons.dashboard, text: AppLocalizations.of(context)!.dashboard),
        ],
      ),
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, "/notification");
            },
          ),
        ],
      ),
      drawer: const DrawerPlate(),
      body: _pages[_selectedIndex],
    );
  }
}
