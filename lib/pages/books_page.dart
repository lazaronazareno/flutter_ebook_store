import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/card_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: context.read<EbookStoreBloc>()..add(FetchBooksEvent()),
        child: const Body());
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: const Center(child: Text("Books")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          if (state.booksScreenStatus == BooksScreenStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.books.isEmpty) {
            return const Center(
              child: Text("No books found"),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 32,
                  childAspectRatio: 0.75),
              padding: const EdgeInsets.only(left: 16, right: 32),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return CardBookWidget(book: book, size: size);
              },
            ),
          );
        },
      ),
    );
  }
}
