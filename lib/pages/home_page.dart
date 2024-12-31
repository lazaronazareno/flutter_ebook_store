import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/search_bar_widget.dart';
import 'package:ebook_store/widgets/trending_books_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            Icons.admin_panel_settings_outlined,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 28,
              )),
          const CircleAvatar(
            backgroundColor: AppColors.orange,
            radius: 20,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: const Column(
        children: [
          SearchBarWidget(),
          SizedBox(height: 16),
          TrendingBooksWidget()
        ],
      ),
    );
  }
}
