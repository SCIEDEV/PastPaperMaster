import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:rive/rive.dart';
import 'package:provider/provider.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Downloads',
              style: MTextStyles.dsmMdGrey900,
            ),
            const Spacer(),
            MButton(
              onPressed: () {
                context.read<DownloadCN>().cancelAll();
              },
              title: "Cancel All",
            ),
            const SizedBox(width: 8),
            MButton(
              onPressed: () {
                context.read<DownloadCN>().retryAllFailed();
              },
              title: "Retry Failed Downloads",
            ),
          ],
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
            children: [
              const DownloadsTableHeader(),
              if (context.watch<DownloadCN>().totalShown == 0)
                const NoDownloadsPlaceholder(),
              for (var i = 0, l = context.watch<DownloadCN>().downloading;
                  i < l.length;
                  i++) ...[
                DownloadEntryRow(
                  item: l[i],
                  isInProgress: true,
                  isLast: context.read<DownloadCN>().totalShown == l.length &&
                      i == l.length - 1,
                ),
              ],
              for (var i = 0, l = context.watch<DownloadCN>().downloadQueue;
                  i < l.length;
                  i++) ...[
                DownloadEntryRow(
                  item: l.elementAt(i),
                  isLast: context.read<DownloadCN>().totalShown ==
                          l.length +
                              context.watch<DownloadCN>().downloading.length &&
                      i == l.length - 1,
                ),
              ],
              for (var i = 0, l = context.watch<DownloadCN>().failed;
                  i < l.length;
                  i++) ...[
                DownloadEntryRow(
                  item: l.elementAt(i),
                  isFailed: true,
                  isLast: context.read<DownloadCN>().totalShown ==
                          l.length +
                              context.watch<DownloadCN>().downloading.length +
                              context
                                  .watch<DownloadCN>()
                                  .downloadQueue
                                  .length &&
                      i == l.length - 1,
                ),
              ],
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
              'Progress',
              style: MTextStyles.xsMdGrey500,
            )),
        const SizedBox(width: 16),
      ]),
    );
  }
}

class DownloadEntryRow extends StatelessWidget {
  const DownloadEntryRow(
      {super.key,
      required this.item,
      this.isLast = false,
      this.isInProgress = false,
      this.isFailed = false});
  final DownloadItem item;
  final bool isLast;
  final bool isInProgress;
  final bool isFailed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8))
              : BorderRadius.zero),
      onPressed: () {
        // TODO: [Micfong] I forgot to implement this...
      },
      fillColor: isInProgress ? MColors.accent.shade50 : MColors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: MColors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  item.name,
                  style: isInProgress
                      ? MTextStyles.smMdAccent700
                      : MTextStyles.smMdGrey900,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  isInProgress
                      ? "${(item.progress * 100).round().toString()}%"
                      : (isFailed ? "Failed" : "Waiting"),
                  style: isFailed
                      ? MTextStyles.smMdAccent700
                      : MTextStyles.smRgGrey500,
                )),
            isInProgress
                ? const SizedBox(width: 16)
                : Icon(FeatherIcons.x, color: MColors.grey.shade500, size: 16),
          ],
        ),
      ),
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
              strokeAlign: BorderSide.strokeAlignOutside),
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
              'Seems like all download tasks have been completed.',
              style: MTextStyles.smRgGrey500,
            ),
          ],
        ));
  }
}
