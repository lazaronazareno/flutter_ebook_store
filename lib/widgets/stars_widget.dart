import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int stars;
  const StarsWidget({super.key, this.stars = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          size: 14,
          Icons.star,
          color: index < stars ? Colors.amber[300] : Colors.grey[300],
        ),
      ),
    );
  }
}
