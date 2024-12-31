import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_rounded),
          ),
        ),
      ),
    );
  }
}
