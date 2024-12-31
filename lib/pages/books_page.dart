import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          if (state.homeScreenStatus == HomeScreenStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.books.isEmpty) {
            return const Center(
              child: Text("No books found"),
            );
          }

          return ListView.builder(
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return SizedBox(
                height: 100,
                width: 100,
                child: Text("Book ${book.title}"),
              );
            },
          );
        },
      ),
    );
  }
}
