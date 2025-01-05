import 'package:ebook_store/model/reading_book_model.dart';
import 'package:ebook_store/pages/reading_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/reading_item_widget.dart';
import 'package:flutter/material.dart';

class CurrentBookWidget extends StatelessWidget {
  final ReadingBookModel book;
  const CurrentBookWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [
              0,
              0.2,
              0.4,
              0.6,
              0.8,
              1
            ],
            colors: [
              AppColors.green,
              Color(0x8740AF9F),
              AppColors.green,
              Color(0x8740AF9F),
              AppColors.green,
              Color(0x8740AF9F)
            ]),
        color: AppColors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_sharp,
            color: Colors.grey[300],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Continue Reading",
                  style: TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.bold)),
              Icon(
                Icons.more_horiz,
                color: AppColors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: size.width,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReadingPage()));
              },
              child: ReadingItemWidget(
                book: book,
                isHomePage: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
