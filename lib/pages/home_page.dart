import 'package:ebook_store/model/reading_book_model.dart';
import 'package:ebook_store/pages/admin_page.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/pages/cart_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/current_book_widget.dart';
import 'package:ebook_store/widgets/search_bar_widget.dart';
import 'package:ebook_store/widgets/trending_books_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookStoreBloc>()
        ..add(FetchBooksEvent())
        ..add(FetchCartEvent())
        ..add(FetchReadingBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  //funcion para comparar si tiene fecha y luego comparar con fecha actual
  ReadingBookModel? getLatestUpdatedBook(List<ReadingBookModel> readingBooks) {
    final validBooks = readingBooks.where((book) {
      return book.updatedAt != "" &&
          book.updatedAt.isNotEmpty &&
          DateTime.tryParse(book.updatedAt) != null;
    }).toList();

    if (validBooks.isEmpty) {
      return null;
    }

    validBooks.sort((a, b) {
      final dateA = DateTime.parse(a.updatedAt);
      final dateB = DateTime.parse(b.updatedAt);
      return dateB.compareTo(dateA);
    });

    return validBooks.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookStoreBloc, EbookStoreState>(
      builder: (context, state) {
        final totalItems = state.cart.fold(0, (previousValue, element) {
          return previousValue + element.quantity;
        });

        final ReadingBookModel? latestUpdatedBook =
            getLatestUpdatedBook(state.readingBooks);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPage()));
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 30,
                  )),
            ),
            actions: [
              SizedBox(
                width: 90,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      right: 52,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartPage()));
                          },
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 28,
                          )),
                    ),
                    const Positioned(
                      top: 8,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: AppColors.orange,
                        radius: 20,
                      ),
                    ),
                    if (state.cart.isNotEmpty) ...[
                      Positioned(
                        right: 56,
                        top: 8,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: Text(
                              totalItems.toString(),
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 4),
              const TrendingBooksWidget(),
              const SizedBox(height: 12),
              if (state.readingBooks.isNotEmpty &&
                  latestUpdatedBook != null) ...[
                Expanded(child: CurrentBookWidget(book: latestUpdatedBook)),
              ]
            ],
          ),
        );
      },
    );
  }
}
