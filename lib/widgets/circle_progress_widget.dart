import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class CircleProgressWidget extends StatelessWidget {
  final double percentage;
  const CircleProgressWidget({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    colorPercentage() {
      if (percentage < 50) {
        return AppColors.green;
      } else if (percentage < 80) {
        return AppColors.orange;
      } else {
        return Colors.red;
      }
    }

    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: 0,
          child: CircularProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[400],
            color: colorPercentage(),
            strokeWidth: 3,
          ),
        ),
        Positioned(
            right: 5,
            bottom: 10,
            child: Text('${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                    color: colorPercentage(),
                    fontWeight: FontWeight.bold,
                    fontSize: 12))),
      ],
    );
  }
}
