import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/slider.dart';
import 'package:past_paper_master/pages/subjects.dart';
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
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 32),
        Text(
          'Filter conditions',
          style: MTextStyles.lgMdGrey900,
        ),
        const SizedBox(height: 4),
        Text(
          'Fill in all conditions that you are using to filter your papers here.',
          style: MTextStyles.smRgGrey500,
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Syllabus',
                        style: MTextStyles.smMdGrey700,
                      ),
                      Text(
                        'Your exam board and corresponding subject.',
                        style: MTextStyles.smRgGrey500,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        MButtonGroup(titles: ['CAIE', 'Edexcel']),
                        SizedBox(width: 16),
                        MButtonGroup(titles: ['(I)GCSE', 'A(S) Level']),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const MLongDropdownButton(
                      title: 'Select subject',
                      iconName: 'book',
                      size: 20,
                      items: igcseSubjects,
                    ),
                  ]),
            ),
            const Spacer(flex: 1),
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
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time range',
                        style: MTextStyles.smMdGrey700,
                      ),
                      Text(
                        'Year and season range of filtered papers.',
                        style: MTextStyles.smRgGrey500,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MRangeSlider(),
                    const SizedBox(height: 16),
                    MLongButton(
                        onPressed: () {},
                        title: 'Select seasons',
                        iconName: 'calendar',
                        size: 20,
                        placeholder: true),
                  ]),
            ),
            const Spacer(flex: 1),
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
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paper type',
                        style: MTextStyles.smMdGrey700,
                      ),
                      Text(
                        'Paper numbers and document types of filtered papers.',
                        style: MTextStyles.smRgGrey500,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 7,
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
            ),
            const Spacer(flex: 1),
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
            const MBadge(title: 'Some fields are not filled in'),
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
