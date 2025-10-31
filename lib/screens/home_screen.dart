import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:mus3if/Tabs/guide_tab.dart';
import 'package:mus3if/Tabs/home_tab.dart';
import 'package:mus3if/Tabs/profile_tab.dart';
=======
import 'package:mus3if/Tabs/home_tab.dart';
import 'package:mus3if/tabs/guide_tab.dart';
import 'package:mus3if/tabs/profile_tab.dart';
>>>>>>> 4f4eee8 (guide and profile tabs)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
<<<<<<< HEAD
  int selectedIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    GuideTab(),
    ProfileTab(),
  ];
=======
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeTab(), GuideTab(), ProfileTab()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
>>>>>>> 4f4eee8 (guide and profile tabs)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(
        title: const Text("Mus3if"),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFDC2626),
        unselectedItemColor: const Color(0xFF64748B),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Guides',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
>>>>>>> 4f4eee8 (guide and profile tabs)
      ),
    );
  }
}
