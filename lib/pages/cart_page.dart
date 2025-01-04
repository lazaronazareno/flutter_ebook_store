import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:ebook_store/widgets/quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookStoreBloc>()..add(FetchCartEvent()),
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
        scrolledUnderElevation: 0,
        title: const Text('Cart'),
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          final total = state.cart.fold(0.0, (previousValue, element) {
            return previousValue + element.price * element.quantity;
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              state.cart.isEmpty
                  ? const Center(
                      child: Text("No products in cart"),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(right: 20, bottom: 8, top: 4),
                      child: Text(
                        "Total: \$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    final book = state.cart[index];
                    return _itemCart(context, book);
                    /* return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        
                        children: [
                          IconButton(
                              onPressed: () {
                                context
                                    .read<EbookStoreBloc>()
                                    .add(RemoveFromCartEvent(id: book.id));
                              },
                              icon: const Icon(Icons.delete)),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(book.cover),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.author),
                          QuantityWidget(book: book, isInCart: true),
                        ],
                      ),
                      trailing: Text('\$${book.price * book.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ); */
                  },
                ),
              ),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
                child: state.cart.isNotEmpty
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text("Checkout",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.white,
                                )),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _itemCart(BuildContext context, BookModel book) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size.width * 0.1,
            child: IconButton(
                onPressed: () {
                  context
                      .read<EbookStoreBloc>()
                      .add(RemoveFromCartEvent(id: book.id));
                },
                icon: const Icon(Icons.delete)),
          ),
          Container(
            width: size.width * 0.17,
            height: size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(book.cover),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(book.author),
                const SizedBox(
                  height: 8,
                ),
                QuantityWidget(book: book, isInCart: true),
              ],
            ),
          ),
          Text('\$${book.price * book.quantity}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
