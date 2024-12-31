import 'package:ebook_store/pages/bookmark_page.dart';
import 'package:ebook_store/pages/home_page.dart';
import 'package:ebook_store/pages/reading_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const ReadingPage(),
    const BookmarkPage()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.orange,
          onTap: onItemTapped,
          backgroundColor: AppColors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Reading',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Bookmarks',
            ),
          ],
        ),
      ),
    );
  }
}
