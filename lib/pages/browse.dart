import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/components/breadcrumb.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:past_paper_master/twotones.dart';
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
          style: MTextStyles.dsm_md_grey_900,
        ),
        const SizedBox(height: 24),
        const Breadcrumbs(),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              color: MColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MColors.grey.shade200, width: 1),
              boxShadow: [
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
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MColors.grey.shade50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Row(children: [
                  Expanded(
                      child: Text(
                        'Entry name',
                        style: MTextStyles.xs_md_grey_500,
                      ),
                      flex: 1),
                  Expanded(
                      child: Text(
                        'Document type',
                        style: MTextStyles.xs_md_grey_500,
                      ),
                      flex: 1),
                ]),
              ),
              NoEntriesPlaceholder(),
            ],
          ),
        ),
      ],
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
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
              color: MColors.grey.shade200,
              width: 1,
              strokeAlign: StrokeAlign.outside),
        ),
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              child: RiveAnimation.asset(
                'assets/rive/empty_folder.riv',
                artboard: 'empty directory',
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'No entries found',
              style: MTextStyles.md_md_grey_900,
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Text(
              'Return to last page using the breadcrumbs above.',
              style: MTextStyles.sm_rg_grey_500,
            ),
            Text(
              'You may report this as an error to SCIE.DEV.',
              style: MTextStyles.sm_rg_grey_500,
            ),
          ],
        ));
  }
}
