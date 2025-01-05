import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final double heightPercentage;
  final double widthPercentage;
  final String text;
  final Function() onPressed;
  final String? actionMessage;
  final bool? variant;

  const ActionButtonWidget(
      {super.key,
      this.heightPercentage = 0.06,
      this.widthPercentage = 0.3,
      required this.text,
      required this.onPressed,
      this.actionMessage = "",
      this.variant = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(variant! ? Colors.grey : AppColors.orange),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(size.width * widthPercentage, size.height * heightPercentage),
        ),
      ),
      onPressed: () {
        onPressed();
        if (actionMessage != null && actionMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(actionMessage!),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.green,
            ),
          );
        }
      },
      child: Text(text, style: const TextStyle(color: AppColors.white)),
    );
  }
}
