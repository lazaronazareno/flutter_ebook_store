import 'package:ebook_store/pages/add_book_page.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookStoreBloc>()..add(FetchBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: const Text("Admin Page"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBookPage()));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          if (state.homeScreenStatus == HomeScreenStatus.loading) {
            return const Center(child: SpinnerWidget());
          }

          if (state.books.isEmpty) {
            return const Center(child: Text("No Books found"));
          }

          return ListView.builder(
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddBookPage(bookModel: book, isEditMode: true))),
                title: Text(book.title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text("\$${book.price.toString()}"),
                trailing: Container(
                  width: 50,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(book.cover),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                leading: IconButton(
                    onPressed: () {
                      context
                          .read<EbookStoreBloc>()
                          .add(DeleteBookEvent(id: book.id));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
