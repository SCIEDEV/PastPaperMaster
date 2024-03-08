import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/box_decorations.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class SearchQuestionsPage extends StatelessWidget {
  const SearchQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Search Questions',
                  style: MTextStyles.dsmMdGrey900,
                ),
                const Spacer(),
                MButtonGroup(
                  titles: const ['All', 'IGCSE', 'A(S) Level'],
                  selected: context.watch<QuestionsCN>().level,
                  onPressed: (context, index) {
                    context.read<QuestionsCN>().level = index;
                  },
                ),
              ],
            ),
            const SizedBox(height: 48),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<QuestionsCN>().results.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox(height: 92);
                  }
                  final question =
                      context.read<QuestionsCN>().results[index - 1];
                  return RowQuestionSearchResult(question: question);
                },
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: MColors.grey.shade50,
                    offset: const Offset(0, 16),
                    blurRadius: 16,
                    spreadRadius: 16,
                  ),
                ],
              ),
              child: MLongDropdownButton(
                title: 'Select subject',
                iconName: 'book',
                size: 20,
                items: kSearchSubjects.keys.toList(),
                onChanged: (context, value) {
                  context.read<QuestionsCN>().subject = value!;
                },
                value: context.watch<QuestionsCN>().subject,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: MColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MColors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: MColors.grey.shade50,
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    spreadRadius: 12,
                  ),
                  const BoxShadow(
                    color: Color(0x19101828),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                  const BoxShadow(
                    color: Color(0x10101828),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type any question here...',
                        hintStyle: MTextStyles.mdRgGrey500,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      onChanged: (value) {
                        context.read<QuestionsCN>().keywords = value;
                      },
                    ),
                  ),
                  MButton(
                    disabled: context.watch<QuestionsCN>().keywords.isEmpty ||
                        context.watch<QuestionsCN>().isSearching,
                    title: 'Search',
                    onPressed: () {
                      context.read<QuestionsCN>().search();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RowQuestionSearchResult extends StatefulWidget {
  const RowQuestionSearchResult({
    super.key,
    required this.question,
  });

  final QuestionResult question;

  @override
  State<RowQuestionSearchResult> createState() =>
      _RowQuestionSearchResultState();
}

class _RowQuestionSearchResultState extends State<RowQuestionSearchResult> {
  bool _showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: MBoxDec.largeBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.question.source,
                          style: MTextStyles.smMdAccent700,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.question.questionContent,
                          style: MTextStyles.mdRgGrey900,
                          softWrap: true,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.question.questionNo,
                          style: MTextStyles.smMdGrey500,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: MColors.grey.shade200,
                      ),
                    ),
                  ),
                  width: 160.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          padding: const EdgeInsets.all(8.0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            showPdfPreview(
                              context,
                              widget.question.sourceQpName,
                              widget.question.sourceQpUrl,
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                widget.question.sourceQpName,
                                style: MTextStyles.smMdGrey900,
                                overflow: TextOverflow.fade,
                              ),
                              const Spacer(),
                              Icon(
                                FeatherIcons.chevronRight,
                                size: 16,
                                color: MColors.grey.shade500,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: widget.question.sourceMsName.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color: MColors.grey.shade200,
                                    ),
                                  ),
                                ),
                                child: RawMaterialButton(
                                  padding: const EdgeInsets.all(8.0),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    showPdfPreview(
                                      context,
                                      widget.question.sourceMsName,
                                      widget.question.sourceMsUrl,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.question.sourceMsName,
                                        style: MTextStyles.smMdGrey900,
                                      ),
                                      const Spacer(),
                                      Icon(
                                        FeatherIcons.chevronRight,
                                        size: 16,
                                        color: MColors.grey.shade500,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                constraints: const BoxConstraints.expand(),
                                alignment: Alignment.centerLeft,
                                // add rounded corner on bottom-right corner
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color: MColors.grey.shade200,
                                    ),
                                  ),
                                  color: MColors.grey.shade100,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'MS not available',
                                  style: MTextStyles.smMdGrey500,
                                ),
                              ),
                      ),
                      Expanded(
                        child: widget.question.answerContent.isNotEmpty
                            ? RawMaterialButton(
                                padding: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: _showAnswers
                                        ? Radius.zero
                                        : const Radius.circular(8),
                                  ),
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  setState(() {
                                    _showAnswers = !_showAnswers;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      _showAnswers
                                          ? 'Hide Answers'
                                          : 'Show Answers',
                                      style: MTextStyles.smMdGrey900,
                                    ),
                                    const Spacer(),
                                    if (_showAnswers)
                                      Icon(
                                        FeatherIcons.chevronUp,
                                        size: 16,
                                        color: MColors.grey.shade500,
                                      )
                                    else
                                      Icon(
                                        FeatherIcons.chevronDown,
                                        size: 16,
                                        color: MColors.grey.shade500,
                                      ),
                                  ],
                                ),
                              )
                            : Container(
                                constraints: const BoxConstraints.expand(),
                                alignment: Alignment.centerLeft,
                                // add rounded corner on bottom-right corner
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: MColors.grey.shade100,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Answer not available',
                                  style: MTextStyles.smMdGrey500,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showAnswers)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: MColors.grey.shade200),
                ),
              ),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Answers',
                    style: MTextStyles.smMdGrey700,
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.question.answerContent,
                      style: MTextStyles.smMonoGrey900,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void showPdfPreview(
    BuildContext context,
    String viewingPdfName,
    String viewingPdfUrl,
  ) {
    viewingPdfName = 'File Preview · $viewingPdfName';
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(viewingPdfName),
              elevation: 8.0,
              shadowColor: const Color(0x19101828),
              titleTextStyle: MTextStyles.lgMdGrey900,
              shape: Border(
                bottom: BorderSide(
                  color: MColors.grey.shade200,
                ),
              ),
              backgroundColor: MColors.white,
              // add a back button
              leading: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  FeatherIcons.chevronLeft,
                  color: MColors.grey.shade700,
                  size: 24,
                ),
              ),
              centerTitle: false,
            ),
            body: PdfViewer.uri(
              params: PdfViewerParams(
                enableTextSelection: true,
                maxScale: 10.0,
                backgroundColor: MColors.grey.shade50,
                errorBannerBuilder: (context, error, stackTrace, documentRef) =>
                    Container(
                  decoration: BoxDecoration(
                    color: MColors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: MColors.grey.shade200,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 48,
                    horizontal: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 64,
                        height: 64,
                        child: RiveAnimation.asset(
                          'assets/rive/empty_folder.riv',
                          artboard: 'empty download',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                        width: double.infinity,
                      ),
                      Text(
                        'Cannot view document',
                        style: MTextStyles.mdMdGrey900,
                      ),
                      const SizedBox(
                        height: 4,
                        width: double.infinity,
                      ),
                      Text(
                        'The document is not a PDF, or a network error occurred.',
                        style: MTextStyles.smRgGrey500,
                      ),
                      Text(
                        'If you believe that this should not have happened, screenshot this page and report it to SCIE.DEV.',
                        style: MTextStyles.smRgGrey500,
                      ),
                      Text(
                        error.toString(),
                        style: MTextStyles.smRgGrey200,
                      ),
                    ],
                  ),
                ),
              ),
              Uri.parse(viewingPdfUrl),
            ),
          );
        },
      ),
    );
  }
}
