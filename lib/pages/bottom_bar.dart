import 'package:flutter/material.dart';
import 'package:tes/pages/bantuan_page.dart';
import 'package:tes/pages/home_page.dart';
import 'package:tes/pages/profile_page.dart';
import 'package:tes/pages/riwayat_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const RiwayatPage(),
    const BantuanPage(),
    const ProfilPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help_outlined),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        backgroundColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 32),
        onTap: _onItemTapped,
      ),
    );
  }
}
