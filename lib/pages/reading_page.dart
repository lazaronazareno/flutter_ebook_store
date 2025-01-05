import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/reading_item_widget.dart';
import 'package:ebook_store/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookStoreBloc>()..add(FetchReadingBooksEvent()),
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
        backgroundColor: AppColors.green,
        title: const Text('Reading', style: TextStyle(color: AppColors.white)),
      ),
      backgroundColor: AppColors.green,
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          if (state.readingScreenStatus == ReadingScreenStatus.loading) {
            return const SpinnerWidget(
              variant: true,
            );
          }

          if (state.readingBooks.isEmpty) {
            return const Center(
              child: Text(
                "No books reading",
                style: TextStyle(color: AppColors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.readingBooks.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final book = state.readingBooks[index];
              return Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: ReadingItemWidget(book: book)),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
