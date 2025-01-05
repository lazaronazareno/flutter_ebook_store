import 'package:ebook_store/model/reading_book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/pages/bookmark_page.dart';
import 'package:ebook_store/pages/home_page.dart';
import 'package:ebook_store/pages/reading_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  Color bgColor = AppColors.white;

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
    return BlocListener<EbookStoreBloc, EbookStoreState>(
      listener: (context, state) {
        bool hasUpdatedBook(List<ReadingBookModel> readingBooks) {
          return readingBooks
              .any((book) => book.updatedAt.isNotEmpty || book.updatedAt != "");
        }

        final isReading = hasUpdatedBook(state.readingBooks);
        if (isReading) {
          setState(() {
            bgColor = AppColors.green;
          });
        }
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        backgroundColor: _selectedIndex == 1
            ? AppColors.green
            : _selectedIndex == 2
                ? AppColors.white
                : bgColor,
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
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Reading',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Bookmarks',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
