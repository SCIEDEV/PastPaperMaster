import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:rive/rive.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Downloads',
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 36),
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
              DownloadsTableHeader(),
              NoDownloadsPlaceholder(),
            ],
          ),
        ),
      ],
    );
  }
}

class DownloadsTableHeader extends StatelessWidget {
  const DownloadsTableHeader({
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
              'Document name',
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

class NoDownloadsPlaceholder extends StatelessWidget {
  const NoDownloadsPlaceholder({
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
                artboard: 'empty download',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'Download queue is empty',
              style: MTextStyles.mdMdGrey900,
            ),
            const SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Text(
              'No documents have been downloaded yet.',
              style: MTextStyles.smRgGrey500,
            ),
          ],
        ));
  }
}
