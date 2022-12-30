import 'package:flutter/material.dart';
import 'package:past_paper_master/textstyle.dart';

class SearchQuestionsPage extends StatelessWidget {
  const SearchQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Questions',
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
