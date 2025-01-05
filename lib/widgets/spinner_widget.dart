import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  final bool variant;
  const SpinnerWidget({super.key, this.variant = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: variant ? AppColors.white : AppColors.green,
      ),
    );
  }
}
