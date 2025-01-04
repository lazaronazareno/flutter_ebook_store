import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/pages/books_page.dart';
import 'package:ebook_store/pages/details_book_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/card_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingBooksWidget extends StatelessWidget {
  const TrendingBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
        const SizedBox(height: 12),
        BlocBuilder<EbookStoreBloc, EbookStoreState>(
          builder: (context, state) {
            if (state.homeScreenStatus == HomeScreenStatus.loading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 42),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state.books.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(
                  top: 42,
                ),
                child: Center(
                  child: Text("No Books in trending"),
                ),
              );
            }

            return SizedBox(
              height: size.height * 0.31,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsBookPage(book: book);
                          }));
                        },
                        child: CardBookWidget(book: book, size: size));
                  }),
            );
          },
        )
      ],
    );
  }
}
