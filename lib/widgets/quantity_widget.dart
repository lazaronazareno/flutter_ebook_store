import 'package:ebook_store/model/book_model.dart';
import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityWidget extends StatefulWidget {
  final BookModel book;
  final bool isInCart;
  const QuantityWidget({
    super.key,
    required this.book,
    this.isInCart = false,
  });

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.book.quantity;
    super.initState();
  }

  void _increment() {
    if (quantity < 5) {
      setState(() {
        quantity++;
        context
            .read<EbookStoreBloc>()
            .add(UpdateCartEvent(book: widget.book, newQuantity: quantity));
      });
    }
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        context
            .read<EbookStoreBloc>()
            .add(UpdateCartEvent(book: widget.book, newQuantity: quantity));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: size.height * 0.06,
          width: widget.isInCart ? size.width * 0.3 : size.width * 0.55,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!widget.isInCart) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("QTY"),
                ),
              ],
              IconButton(
                onPressed: () {
                  _decrement();
                },
                icon: const Icon(Icons.remove),
              ),
              Text(quantity.toString(),
                  style: const TextStyle(
                      color: AppColors.green, fontWeight: FontWeight.w600)),
              IconButton(
                onPressed: () {
                  _increment();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        if (!widget.isInCart)
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
            onPressed: () {
              context.read<EbookStoreBloc>().add(AddToCartEvent(
                    id: widget.book.id,
                    quantity: quantity,
                  ));
            },
            child: const Text("Add to cart",
                style: TextStyle(color: AppColors.white)),
          )
      ],
    );
  }
}
