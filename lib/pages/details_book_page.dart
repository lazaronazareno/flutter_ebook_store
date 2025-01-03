import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/box_details_widget.dart';
import 'package:ebook_store/widgets/quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBookPage extends StatelessWidget {
  final BookModel book;
  const DetailsBookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        title: const Center(child: Text("Detail Book")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.3,
            width: size.width,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.3),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(book.cover),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          BlocBuilder<EbookStoreBloc, EbookStoreState>(
            builder: (context, state) {
              return _buildInfoBook(size, context, state);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBook(
      Size size, BuildContext context, EbookStoreState state) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -1),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${book.price.toString()}",
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    book.title,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: IconButton(
                    onPressed: () => {
                          print(state.bookmarks.contains(book)),
                          context
                              .read<EbookStoreBloc>()
                              .add(AddToBookmarksEvent(id: book.id))
                        },
                    icon: state.bookmarks.contains(book)
                        ? const Icon(
                            Icons.bookmark,
                            color: AppColors.white,
                          )
                        : const Icon(
                            Icons.bookmark_border,
                            color: AppColors.white,
                          )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const BoxDetailsWidget(),
          const SizedBox(height: 12),
          Text(
            book.description,
            maxLines: 3,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height * 0.06,
                width: size.width * 0.55,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("QTY"),
                    ),
                    QuantityWidget(initialQuantity: book.quantity)
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.orange),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    Size(size.width * 0.3, size.height * 0.06),
                  ),
                ),
                onPressed: () {},
                child: const Text("Add to cart",
                    style: TextStyle(color: AppColors.white)),
              )
            ],
          )
        ],
      ),
    );
  }
}
