import '../../common/colo_extension.dart';
import 'package:flutter/material.dart';

class ExercisesRow extends StatelessWidget {
  final Map eObj;
  final VoidCallback onPressed;
  final bool check;
  const ExercisesRow(
      {super.key,
      required this.eObj,
      required this.check,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              eObj["image"].toString(),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eObj["title"].toString(),
                style: TextStyle(
                    color: TColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                eObj["value"].toString(),
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              ),
            ],
          )),
          if (check)
            IconButton(
                onPressed: onPressed,
                icon: Image.asset(
                  "/images/next_go.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ))
        ],
      ),
    );
  }
}
