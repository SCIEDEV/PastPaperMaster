import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';

class MBadge extends StatelessWidget {
  const MBadge({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MColors.accent.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 8, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: MColors.accent,
                borderRadius: BorderRadius.circular(3),
              ),
              width: 6,
              height: 6,
              margin: const EdgeInsets.all(2),
            ),
            const SizedBox(width: 6),
            Text(title,
                style: TextStyle(
                    color: MColors.accent.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14))
          ],
        ));
  }
}
