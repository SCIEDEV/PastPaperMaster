import 'package:flutter/material.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:rive/rive.dart';

class SearchQuestionsPage extends StatelessWidget {
  const SearchQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 36),
        SizedBox(
          width: 256,
          height: 256,
          child: RiveAnimation.asset(
            'assets/rive/qsearch.riv',
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Coming soon',
          style: MTextStyles.mdMdGrey900,
        ),
      ],
    );
  }
}
