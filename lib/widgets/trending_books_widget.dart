import 'package:ebook_store/data.dart';
import 'package:ebook_store/pages/books_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class TrendingBooksWidget extends StatelessWidget {
  const TrendingBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Trending books",
                  style: TextStyle(
                      color: AppColors.black, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const BooksPage();
                  }));
                },
                child: const Text(
                  "See all",
                  style: TextStyle(color: AppColors.black),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: size.height * 0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: booksData.length,
                itemBuilder: (context, index) {
                  final book = booksData[index];
                  return Container(
                    width: size.width * 0.3,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.23,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(
                            book['cover'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "by ${book['author']}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(book['title'],
                            style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
