import 'package:flutter/material.dart';
import 'package:past_paper_master/textstyle.dart';

class PseudocodeRunnerPage extends StatelessWidget {
  const PseudocodeRunnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pseudocode Runner',
          style: MTextStyles.dsm_md_grey_900,
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
