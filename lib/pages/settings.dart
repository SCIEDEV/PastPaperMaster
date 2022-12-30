import 'package:flutter/material.dart';
import 'package:past_paper_master/textstyle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: MTextStyles.dsm_md_grey_900,
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
