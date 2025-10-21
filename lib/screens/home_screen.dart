import 'package:flutter/material.dart';
import 'package:mus3if/Tabs/guide_tab.dart';
import 'package:mus3if/Tabs/home_tab.dart';
import 'package:mus3if/Tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    GuideTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.red.withOpacity(0.6),
        selectedFontSize: 15,
        unselectedFontSize: 0,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: buildIcon(Icons.home_filled, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.note_alt, 1),
            label: "Guides",
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.person, 2),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, int index) {
    bool isSelected = selectedIndex == index;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(isSelected ? 6 : 0),
      decoration: isSelected
          ? BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      )
          : null,
      child: Icon(
        icon,
        size: isSelected ? 30 : 25,
        color: isSelected ? Colors.red : Colors.red.withOpacity(0.6),
      ),
    );
  }
}
