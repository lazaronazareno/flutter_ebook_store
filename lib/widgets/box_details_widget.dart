import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class BoxDetailsWidget extends StatelessWidget {
  const BoxDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
          color: AppColors.greyDetails,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rating",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text("4.5",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
            ],
          ),
          Text("|", style: TextStyle(color: Colors.grey, fontSize: 20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Number of pages",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text("185 pages",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
            ],
          ),
          Text("|", style: TextStyle(color: Colors.grey, fontSize: 20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Language",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text("ENG",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
