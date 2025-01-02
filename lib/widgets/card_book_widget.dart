import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class CardBookWidget extends StatelessWidget {
  final BookModel book;
  final Size size;
  const CardBookWidget({super.key, required this.book, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.33,
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: size.height * 0.23,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(book.cover),
                  fit: BoxFit.fill,
                ),
              )),
          Text(
            "by ${book.author}",
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                overflow: TextOverflow.ellipsis),
          ),
          Text(book.title,
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
