import 'package:flutter/material.dart';

class QuantityWidget extends StatefulWidget {
  final int initialQuantity;
  const QuantityWidget({super.key, required this.initialQuantity});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.initialQuantity;
    super.initState();
  }

  void _increment() {
    if (quantity < 5) {
      setState(() {
        quantity++;
      });
    }
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _decrement();
          },
          icon: const Icon(Icons.remove),
        ),
        Text(quantity.toString()),
        IconButton(
          onPressed: () {
            _increment();
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
