import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookStoreBloc>()..add(FetchBookmarksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          if (state.bookmarksScreenStatus == BookMarkScreenStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ),
            );
          }

          if (state.bookmarks.isEmpty) {
            return const Center(
              child: Text('No bookmarks yet'),
            );
          }

          return ListView.builder(
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final book = state.bookmarks[index];
              return ListTile(
                leading: Container(
                  width: size.width * 0.15,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(book.cover),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(book.title,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(book.author,
                    style: TextStyle(color: Colors.grey[600])),
                trailing: IconButton(
                    onPressed: () {
                      context
                          .read<EbookStoreBloc>()
                          .add(RemoveFromBookmarksEvent(id: book.id));
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: AppColors.green,
                      size: 32,
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
