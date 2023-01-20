import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/components/breadcrumb.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:rive/rive.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse',
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 24),
        const Breadcrumbs(),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              color: MColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MColors.grey.shade200, width: 1),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x19101828),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: -2),
                BoxShadow(
                    color: Color(0x10101828),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2),
              ]),
          child: Column(
            children: const [
              BrowseTableHeader(),
              NoEntriesPlaceholder(),
            ],
          ),
        ),
      ],
    );
  }
}

class BrowseTableHeader extends StatelessWidget {
  const BrowseTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MColors.grey.shade50,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Text(
              'Entry name',
              style: MTextStyles.xsMdGrey500,
            )),
        Expanded(
            flex: 1,
            child: Text(
              'Document type',
              style: MTextStyles.xsMdGrey500,
            )),
      ]),
    );
  }
}

class NoEntriesPlaceholder extends StatelessWidget {
  const NoEntriesPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
              color: MColors.grey.shade200,
              width: 1,
              strokeAlign: StrokeAlign.outside),
        ),
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 64,
              height: 64,
              child: RiveAnimation.asset(
                'assets/rive/empty_folder.riv',
                artboard: 'empty directory',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'No entries found',
              style: MTextStyles.mdMdGrey900,
            ),
            const SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Text(
              'Return to last page using the breadcrumbs above.',
              style: MTextStyles.smRgGrey500,
            ),
            Text(
              'You may report this as an error to SCIE.DEV.',
              style: MTextStyles.smRgGrey500,
            ),
          ],
        ));
  }
}
