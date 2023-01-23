import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/slider.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/pages/subjects.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:provider/provider.dart';

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
                      children: [
                        MButtonGroup(
                            // TODO: [Micfong] implement Edexcel subjects
                            titles: const ['CAIE'],
                            onPressed: (context, index) {
                              context.read<FilterCN>().board =
                                  ['CAIE', 'Edexcel'][index];
                              context.read<FilterCN>().subject = null;
                            }),
                        const SizedBox(width: 16),
                        MButtonGroup(
                            titles: const ['IGCSE', 'A(S) Level'],
                            onPressed: (context, index) {
                              context.read<FilterCN>().level =
                                  ['IGCSE', 'A(S) Level'][index];
                              context.read<FilterCN>().subject = null;
                            }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MLongDropdownButton(
                      title: 'Select subject',
                      iconName: 'book',
                      size: 20,
                      items: (context.watch<FilterCN>().level == 'IGCSE')
                          ? igcseSubjects
                          : alevelSubjects,
                      onChanged: (context, value) {
                        context.read<FilterCN>().subject = value;
                      },
                      value: context.watch<FilterCN>().subject,
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
                    MLongComboDropdownButton(
                      title: 'Select seasons',
                      iconName: 'calendar',
                      size: 20,
                      items: const [
                        'February / March (m)',
                        'May / June (s)',
                        'October / November (w)'
                      ],
                      onChanged: (context, value) {
                        if (value != null) {
                          context.read<FilterCN>().toggleSeason(value);
                        }
                      },
                      initValue: context.read<FilterCN>().seasons,
                      fieldName: 'season',
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
                    MLongComboDropdownButton(
                      title: 'Select paper numbers',
                      iconName: 'list',
                      size: 20,
                      items: const [
                        'Paper 1',
                        'Paper 2',
                        'Paper 3',
                        'Paper 4',
                        'Paper 5',
                        'Paper 6',
                      ],
                      onChanged: (context, value) {
                        if (value != null) {
                          context.read<FilterCN>().togglePaperNumber(value);
                        }
                      },
                      initValue: context.read<FilterCN>().paperNumbers,
                      fieldName: 'paper number',
                    ),
                    const SizedBox(height: 16),
                    MLongComboDropdownButton(
                      title: 'Select document types',
                      iconName: 'grid',
                      size: 20,
                      items: const [
                        'Question paper',
                        'Mark scheme',
                      ],
                      onChanged: (context, value) {
                        if (value != null) {
                          context.read<FilterCN>().togglePaperType(value);
                        }
                      },
                      initValue: context.read<FilterCN>().paperTypes,
                      fieldName: 'paper type',
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
