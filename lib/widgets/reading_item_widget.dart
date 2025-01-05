import 'package:ebook_store/model/reading_book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/action_button_widget.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/circle_progress_widget.dart';
import 'package:ebook_store/widgets/stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingItemWidget extends StatelessWidget {
  final ReadingBookModel book;
  final bool isHomePage;
  const ReadingItemWidget(
      {super.key, required this.book, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double percentage = (book.currentPage / book.totalPages) * 100;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 5),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            width: size.width * 0.15,
            height: size.height * 0.10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(book.cover),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  book.author,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                StarsWidget(
                  stars: book.stars,
                )
              ],
            ),
          ),
          if (!isHomePage) ...[
            Positioned(
              right: 0,
              bottom: -4,
              child: ActionButtonWidget(
                text: book.isReading ? "Reading" : "Start Reading",
                onPressed: () {
                  context
                      .read<EbookStoreBloc>()
                      .add(AddToReadingEvent(id: book.id));
                },
                variant: book.isReading ? true : false,
              ),
            ),
          ] else ...[
            Positioned(
                right: 4,
                bottom: 12,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleProgressWidget(percentage: percentage))),
          ]
        ],
      ),
    );
  }
}
