import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/slider.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/subjects.dart';
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // TODO: [Micfong] implement Edexcel subjects
                      // MButtonGroup(
                      //     titles: const ['CAIE'],
                      //     onPressed: (context, index) {
                      //       context.read<FilterCN>().board =
                      //           ['CAIE', 'Edexcel'][index];
                      //       context.read<FilterCN>().subject = null;
                      //     }),
                      // const SizedBox(width: 16),
                      MButtonGroup(
                        titles: const ['IGCSE', 'A(S) Level'],
                        selected:
                            context.watch<FilterCN>().level == 'IGCSE' ? 0 : 1,
                        onPressed: (context, index) {
                          context.read<FilterCN>().level =
                              ['IGCSE', 'A(S) Level'][index];
                          context.read<FilterCN>().subject = null;
                        },
                      ),
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
                ],
              ),
            ),
            const Spacer(),
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
                  ],
                ),
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
                      'October / November (w)',
                    ],
                    onChanged: (context, value) {
                      if (value != null) {
                        context.read<FilterCN>().toggleSeason(value);
                      }
                    },
                    initValue: context.read<FilterCN>().seasons,
                    fieldName: 'season',
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                  ],
                ),
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
                      'Examiner report',
                      'Grade thresholds',
                      'Specimen paper',
                      'Specimen mark scheme',
                      'Others',
                    ],
                    onChanged: (context, value) {
                      if (value != null) {
                        context.read<FilterCN>().togglePaperType(value);
                      }
                    },
                    initValue: context.read<FilterCN>().paperTypes,
                    fieldName: 'paper type',
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MButton(
              onPressed: () {
                final instance = context.read<FilterCN>();
                final PaperFilterResult result = _getPapers(
                  instance.level,
                  instance.subject ?? "",
                  instance.startYear,
                  instance.endYear,
                  instance.seasons,
                  instance.paperNumbers,
                  instance.paperTypes,
                );
                if (result.successful == false) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Failed to filter papers"),
                      content: Text(result.failMessage),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Dismiss"),
                        ),
                      ],
                    ),
                  );
                } else {
                  context.read<CheckoutCN>().items.addAll(result.papers);
                  if (kDebugMode) {
                    final items = context.read<CheckoutCN>().items;
                    for (final item in items) {
                      print("${item.name} ${item.path} ${item.hashCode}");
                    }
                  }
                  ScaffoldMessenger.of(globalContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${result.papers.length} papers added to checkout.",
                      ),
                      action: SnackBarAction(
                        label: "Dismiss",
                        onPressed: () {
                          ScaffoldMessenger.of(globalContext)
                              .hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                }
              },
              title: 'Add to Checkout',
            ),
            const SizedBox(width: 12),
            MButton(
              onPressed: () {
                if (context.read<DownloadCN>().downloadPath == '') {
                  // show alertdialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: MColors.white,
                      titleTextStyle: MTextStyles.lgMdGrey900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text("No download path selected"),
                      content: Text(
                        "Please select a download path in the settings page.",
                        style: MTextStyles.smRgGrey500,
                      ),
                      actions: [
                        MButton(
                          title: 'Dismiss',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  final instance = context.read<FilterCN>();
                  final PaperFilterResult result = _getPapers(
                    instance.level,
                    instance.subject ?? "",
                    instance.startYear,
                    instance.endYear,
                    instance.seasons,
                    instance.paperNumbers,
                    instance.paperTypes,
                  );
                  if (result.successful == false) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Failed to filter papers"),
                        content: Text(result.failMessage),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Dismiss"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    context.read<DownloadCN>().addDownloads(result.papers);
                    if (kDebugMode) {
                      final items = context.read<CheckoutCN>().items;
                      for (final item in items) {
                        print("${item.name} ${item.path} ${item.hashCode}");
                      }
                    }

                    ScaffoldMessenger.of(globalContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${result.papers.length} papers added to download queue.",
                        ),
                        action: SnackBarAction(
                          label: "Dismiss",
                          onPressed: () {
                            ScaffoldMessenger.of(globalContext)
                                .hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                }
              },
              title: 'Download',
              primary: true,
            ),
          ],
        ),
      ],
    );
  }
}

class PaperFilterResult {
  bool successful;
  Set<CheckoutItem> papers;
  String failMessage;

  PaperFilterResult(this.successful, this.papers, this.failMessage);
}

PaperFilterResult _getPapers(
  String level,
  String subject,
  int startYear,
  int endYear,
  List<String> seasons,
  List<String> paperNumbers,
  List<String> paperTypes,
) {
  final PaperFilterResult ret = PaperFilterResult(true, {}, '');
  Map<String, dynamic> paperMap;

  if (kDebugMode) {
    print('level: $level');
    print('subject: $subject');
    print('startYear: $startYear');
    print('endYear: $endYear');
    print('seasons: $seasons');
    print('paperNumbers: $paperNumbers');
    print('paperTypes: $paperTypes');
  }

  if (subject == '') {
    ret.successful = false;
    ret.failMessage = 'Please select a subject.';
    return ret;
  }

  if (seasons.isEmpty) {
    ret.successful = false;
    ret.failMessage = 'Please select at least one season.';
    return ret;
  }

  if (paperNumbers.isEmpty) {
    ret.successful = false;
    ret.failMessage = 'Please select at least one paper number.';
    return ret;
  }

  if (paperTypes.isEmpty) {
    ret.successful = false;
    ret.failMessage = 'Please select at least one paper type.';
    return ret;
  }

  if (level == 'IGCSE') {
    paperMap = igcseSubjectsMap;
  } else {
    paperMap = alevelSubjectsMap;
  }

  if (!paperMap.containsKey(subject)) {
    ret.successful = false;
    ret.failMessage = '''
Filtering is not yet supported for this subject.

You may download the papers from Browse page instead.''';
    return ret;
  }

  final dynamic temp = paperMap[subject];
  if (temp is List) {
    ret.successful = false;
    ret.failMessage = '''
Filtering is not yet supported for this subject.

You may download the papers from Browse page instead.''';
    return ret;
  }

  final List<dynamic> keys = temp.keys.toList();
  if (kDebugMode) {
    print(temp.keys);
  }
  if (keys.any((e) => temp[e].isEmpty)) {
    ret.successful = false;
    ret.failMessage = '''
Filtering is not yet supported for this subject.

You may download the papers from Browse page instead.''';
    return ret;
  }

  final Map<String, String> seasonConvert = {
    'm': 'February / March (m)',
    's': 'May / June (s)',
    'w': 'October / November (w)',
  };

  final Map<String, String> paperTypeConvert = {
    'qp': 'Question paper',
    'ms': 'Mark scheme',
    'er': 'Examiner report',
    'gt': 'Grade thresholds',
    'sp': 'Specimen paper',
    'sm': 'Specimen mark scheme',
  };
  for (int year = startYear; year <= endYear; year++) {
    if (temp.containsKey(year.toString())) {
      final List<dynamic> papers = temp[year.toString()];
      for (var paper in papers) {
        final orginalPaper = paper;
        paper = paper.replaceAll(RegExp(r'\..+$'), '');
        final List<String> components = paper.split('_');
        if (kDebugMode) {
          print(paper);
          print(components);
        }
        final String season = seasonConvert[components[1][0]] ?? '';
        if (season == '' || !seasons.contains(season)) {
          if (kDebugMode) {
            print('Season validation failed: $season -> $seasons');
          }
          continue;
        }
        final String paperType = paperTypeConvert[components[2]] ?? '';
        if (paperType == '' || !paperTypes.contains(paperType)) {
          if (!(components[2] == 'ot' && paperTypes.contains('Others'))) {
            if (kDebugMode) {
              print('Paper type validation failed');
            }
            continue;
          }
        }
        if (components.length == 4) {
          if (!paperNumbers.contains("Paper ${components[3][0]}")) {
            if (kDebugMode) {
              print('Paper number validation failed');
            }
            continue;
          }
        }
        final CheckoutItem item = CheckoutItem(orginalPaper, []);
        item.path.add(level);
        item.path.add(subject);
        item.path.add(year.toString());
        ret.papers.add(item);
      }
    }
  }

  if (kDebugMode) {
    print("Papers: ${ret.papers.length}");
    for (final paper in ret.papers) {
      print(paper.name);
    }
  }

  return ret;
}
