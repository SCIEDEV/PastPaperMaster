import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/slider.dart';
import 'package:past_paper_master/textstyle.dart';

class PaperFilterPage extends StatelessWidget {
  const PaperFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paper Filter',
          style: MTextStyles.dsm_md_grey_900,
        ),
        const SizedBox(height: 32),
        Text(
          'Filter conditions',
          style: MTextStyles.lg_md_grey_900,
        ),
        const SizedBox(height: 4),
        Text(
          'Fill in all conditions that you are using to filter your papers here.',
          style: MTextStyles.sm_rg_grey_500,
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Syllabus',
                        style: MTextStyles.sm_md_grey_700,
                      ),
                      Text(
                        'Your exam board and corresponding subject.',
                        style: MTextStyles.sm_rg_grey_500,
                      ),
                    ]),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MButtonGroup(titles: ['CAIE', 'Edexcel']),
                        const SizedBox(width: 16),
                        MButtonGroup(titles: ['(I)GCSE', 'A(S) Level']),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MLongButton(
                      title: 'Select subject',
                      onPressed: () {},
                      placeholder: true,
                      iconName: 'book',
                      size: 20,
                    ),
                  ]),
              flex: 7,
            ),
            Spacer(flex: 1),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time range',
                        style: MTextStyles.sm_md_grey_700,
                      ),
                      Text(
                        'Year and season range of filtered papers.',
                        style: MTextStyles.sm_rg_grey_500,
                      ),
                    ]),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MRangeSlider(),
                    const SizedBox(height: 16),
                    MLongButton(
                        onPressed: () {},
                        title: 'Select seasons',
                        iconName: 'calendar',
                        size: 20,
                        placeholder: true),
                  ]),
              flex: 7,
            ),
            Spacer(flex: 1),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paper type',
                        style: MTextStyles.sm_md_grey_700,
                      ),
                      Text(
                        'Paper numbers and document types of filtered papers.',
                        style: MTextStyles.sm_rg_grey_500,
                      ),
                    ]),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MLongButton(
                        onPressed: () {},
                        title: 'Select paper numbers',
                        iconName: 'list',
                        size: 20,
                        placeholder: true),
                    const SizedBox(height: 16),
                    MLongButton(
                        onPressed: () {},
                        title: 'Select document types',
                        iconName: 'grid',
                        size: 20,
                        placeholder: true),
                  ]),
              flex: 7,
            ),
            Spacer(flex: 1),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MBadge(title: 'Some fields are not filled in'),
            const SizedBox(width: 12),
            MButton(
              onPressed: () {},
              title: 'Add to Checkout',
              primary: false,
            ),
            const SizedBox(width: 12),
            MButton(
              onPressed: () {},
              title: 'Download',
              primary: true,
            )
          ],
        ),
      ],
    );
  }
}
