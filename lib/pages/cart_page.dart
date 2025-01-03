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
        title: const Text('Cart'),
      ),
      body: BlocBuilder<EbookStoreBloc, EbookStoreState>(
        builder: (context, state) {
          final total = state.cart.fold(0.0, (previousValue, element) {
            return previousValue + element.price * element.quantity;
          });
          if (state.cartScreenStatus == CartScreenStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.green,
              ),
            );
          }

          if (state.cart.isEmpty) {
            return const Center(
              child: Text('Cart is empty'),
            );
          }

          return Column(
            children: [
              Text('Total: \$${total.toStringAsFixed(2)}'),
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    final book = state.cart[index];
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${book.quantity}'),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.remove)),
                        ],
                      ),
                      title: Text(book.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.author),
                          QuantityWidget(book: book, isInCart: true),
                        ],
                      ),
                      trailing: Text('\$${book.price * book.quantity}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
