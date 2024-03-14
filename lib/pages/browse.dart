import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:past_paper_master/components/breadcrumb.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/dialogs.dart';
import 'package:past_paper_master/core/box_decorations.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/subjects.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BrowsePageHeading(),
            Spacer(),
            MButtonClearSelection(),
            SizedBox(width: 8),
            MButtonAddToCheckout(),
            SizedBox(width: 8),
            MButtonDownload(),
          ],
        ),
        SizedBox(height: 24),
        Breadcrumbs(),
        SizedBox(height: 16),
        BrowsePageTable(),
      ],
    );
  }
}

class BrowsePageTable extends StatelessWidget {
  const BrowsePageTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = getEntries(context.watch<BrowseCN>().path);
    return Container(
      decoration: MBoxDec.largeBoxDecoration,
      child: Column(
        children: [
          const BrowseTableHeader(),
          if (getEntries(context.watch<BrowseCN>().path).isEmpty)
            const NoEntriesPlaceholder(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: l.length,
            itemBuilder: (context, i) => BrowseEntryRow(
              entryName: l[i].name,
              documentType: l[i].type,
              isLast: i == l.length - 1,
              isDocument: l[i].isDocument,
              isSelected: context.watch<BrowseCN>().isSelected(l[i].name),
            ),
          ),
        ],
      ),
    );
  }
}

class BrowsePageHeading extends StatelessWidget {
  const BrowsePageHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<BrowseCN>().selection.isEmpty
          ? 'Browse'
          : '${context.watch<BrowseCN>().selection.length} selected',
      style: MTextStyles.dsmMdGrey900,
    );
  }
}

class MButtonDownload extends StatelessWidget {
  const MButtonDownload({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MButton(
      title: "Download",
      onPressed: () {
        if (context.read<DownloadCN>().downloadPath == '') {
          // show alertdialog
          showDialog(
            context: context,
            builder: (context) => const MAlertDialogNoDownloadPath(),
          );
        } else {
          final Set<CheckoutItem> selection =
              context.read<BrowseCN>().selection;
          context.read<DownloadCN>().addDownloads(selection);

          ScaffoldMessenger.of(globalContext).showSnackBar(
            SnackBar(
              content:
                  Text("${selection.length} papers added to download queue."),
              action: SnackBarAction(
                label: "Dismiss",
                onPressed: () {
                  ScaffoldMessenger.of(globalContext).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      primary: true,
    );
  }
}

class MButtonClearSelection extends StatelessWidget {
  const MButtonClearSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MButton(
      title: "Clear Selection",
      onPressed: () {
        context.read<BrowseCN>().clearSelection();
      },
    );
  }
}

class MButtonAddToCheckout extends StatelessWidget {
  const MButtonAddToCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MButton(
      title: "Add to Checkout",
      onPressed: () {
        final Set<CheckoutItem> selection = context.read<BrowseCN>().selection;
        context.read<CheckoutCN>().items.addAll(selection);

        ScaffoldMessenger.of(globalContext).showSnackBar(
          SnackBar(
            content: Text("${selection.length} papers added to checkout."),
            action: SnackBarAction(
              label: "Dismiss",
              onPressed: () {
                ScaffoldMessenger.of(globalContext).hideCurrentSnackBar();
              },
            ),
          ),
        );
      },
    );
  }
}

class BrowseEntry {
  final String name;
  final String type;
  final bool isDocument;
  BrowseEntry({
    required this.name,
    required this.type,
    this.isDocument = false,
  });
}

List<BrowseEntry> getEntries(List<String> path) {
  if (path.isEmpty) {
    return [
      BrowseEntry(name: "IGCSE", type: "Qualification"),
      BrowseEntry(name: "A(S) Level", type: "Qualification"),
    ];
  }
  dynamic temp;
  final List<BrowseEntry> ret = [];
  if (path[0] == "IGCSE") {
    temp = igcseSubjectsMap;
    for (var i = 1; i < path.length; i++) {
      if (!temp.containsKey(path[i])) return [];
      temp = temp[path[i]];
    }
    if (temp is List) {
      for (var i = 0; i < temp.length; i++) {
        ret.add(
          BrowseEntry(
            name: temp[i] as String,
            type: "Document",
            isDocument: true,
          ),
        );
      }
    } else {
      for (var i = 0; i < temp.keys.length; i++) {
        if (temp.keys.elementAt(i).contains('.')) {
          ret.add(
            BrowseEntry(
              name: temp.keys.elementAt(i),
              type: "Document",
              isDocument: true,
            ),
          );
        } else {
          ret.add(BrowseEntry(name: temp.keys.elementAt(i), type: "Folder"));
        }
      }
    }
    return ret;
  } else if (path[0] == "A(S) Level") {
    temp = alevelSubjectsMap;
    for (var i = 1; i < path.length; i++) {
      if (!temp.containsKey(path[i])) return [];
      temp = temp[path[i]];
    }
    if (temp is List) {
      for (var i = 0; i < temp.length; i++) {
        ret.add(
          BrowseEntry(
            name: temp[i] as String,
            type: "Document",
            isDocument: true,
          ),
        );
      }
    } else {
      for (var i = 0; i < temp.keys.length; i++) {
        if (temp.keys.elementAt(i).contains('.')) {
          ret.add(
            BrowseEntry(
              name: temp.keys.elementAt(i),
              type: "Document",
              isDocument: true,
            ),
          );
        } else {
          ret.add(BrowseEntry(name: temp.keys.elementAt(i), type: "Folder"));
        }
      }
    }
    return ret;
  }
  return [];
}

class BrowseEntryRow extends StatelessWidget {
  const BrowseEntryRow({
    super.key,
    required this.entryName,
    required this.documentType,
    this.isLast = false,
    this.isDocument = false,
    this.isSelected = false,
  });
  final String entryName;
  final String documentType;
  final bool isLast;
  final bool isDocument;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: isLast
            ? const BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              )
            : BorderRadius.zero,
      ),
      onPressed: isDocument
          ? () {
              context.read<BrowseCN>().toggleSelection(entryName);
            }
          : () {
              context.read<BrowseCN>().addPath(entryName);
            },
      fillColor: isSelected ? MColors.accent.shade50 : MColors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: MColors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                entryName,
                style: isSelected
                    ? MTextStyles.smMdAccent700
                    : MTextStyles.smMdGrey900,
              ),
            ),
            Expanded(
              child: Text(
                documentType,
                style: MTextStyles.smRgGrey500,
              ),
            ),
            if (isDocument)
              Row(
                children: [
                  // add a pressable view icon that does not change row height
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: RawMaterialButton(
                      onPressed: () {
                        showPdfPreview(context);
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Icon(
                        FeatherIcons.eye,
                        color: MColors.grey.shade500,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (isSelected)
                    Icon(
                      Icons.square_rounded,
                      color: MColors.accent.shade500,
                      size: 16,
                    )
                  else
                    Icon(
                      Icons.check_box_outline_blank,
                      color: MColors.grey.shade500,
                      size: 16,
                    ),
                ],
              )
            else
              Row(
                children: [
                  const SizedBox(width: 32),
                  Icon(
                    FeatherIcons.chevronRight,
                    color: MColors.grey.shade500,
                    size: 16,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void showPdfPreview(BuildContext context) {
    context.read<BrowseCN>().viewingPdfName = entryName;
    final String viewingPdfName =
        'File Preview · ${context.read<BrowseCN>().viewingPdfName}';
    final String viewingPdfUrl =
        context.read<BrowseCN>().getViewingDocumentUrl();
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
                loadingBannerBuilder: (context, bytesDownloaded, totalBytes) {
                  return Center(
                      child: Text(
                    'Loading document...',
                    style: MTextStyles.smRgGrey500,
                  ));
                },
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

class BrowseTableHeader extends StatelessWidget {
  const BrowseTableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MColors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.only(top: 12, left: 24, bottom: 12, right: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Entry name',
              style: MTextStyles.xsMdGrey500,
            ),
          ),
          Expanded(
            child: Text(
              'Entry type',
              style: MTextStyles.xsMdGrey500,
            ),
          ),
          const SizedBox(width: 26),
          SizedBox(
            width: 28,
            height: 28,
            child: context.watch<BrowseCN>().hasDocumentOnPage()
                ? RawMaterialButton(
                    onPressed: () {
                      if (context.read<BrowseCN>().pageSelectionStatus() ==
                          true) {
                        context.read<BrowseCN>().deselectAllOnPage();
                      } else {
                        context.read<BrowseCN>().selectAllOnPage();
                      }
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: (context.watch<BrowseCN>().pageSelectionStatus() ==
                            false)
                        ? Icon(
                            Icons.check_box_outline_blank,
                            color: MColors.grey.shade500,
                            size: 16,
                          )
                        : (context.watch<BrowseCN>().pageSelectionStatus() ==
                                null)
                            ? Icon(
                                Icons.indeterminate_check_box_outlined,
                                color: MColors.grey.shade500,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outlined,
                                color: MColors.grey.shade500,
                                size: 16,
                              ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

class NoEntriesPlaceholder extends StatelessWidget {
  const NoEntriesPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
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
      ),
    );
  }
}
