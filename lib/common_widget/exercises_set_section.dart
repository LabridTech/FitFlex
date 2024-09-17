import 'dart:math';

import 'package:flutter/material.dart';

import '../common/colo_extension.dart';
import 'exercises_row.dart';

class ExercisesSetSection extends StatelessWidget {
  final Map sObj;
  final Function(Map obj) onPressed;
  const ExercisesSetSection(
      {super.key, required this.sObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 8,
        ),
        ExercisesRow(
          eObj: sObj,
          check: true,
          onPressed: () {
            onPressed(sObj);
          },
        ),
      ],
    );
  }
}
