import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/dialogs.dart';
import 'package:past_paper_master/core/box_decorations.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var checkoutItems = context.watch<CheckoutCN>().items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          checkoutItems.isEmpty
              ? 'Checkout'
              : "Checkout - ${checkoutItems.length} item${context.read<CheckoutCN>().items.length == 1 ? '' : 's'}",
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            MButton(
              onPressed: () {
                if (context.read<CheckoutCN>().selected.length ==
                    context.read<CheckoutCN>().items.length) {
                  context.read<CheckoutCN>().selectNone();
                } else {
                  context.read<CheckoutCN>().selectAll();
                }
              },
              title: (context.watch<CheckoutCN>().selected.length ==
                      checkoutItems.length)
                  ? "Select None"
                  : "Select All",
            ),
            const SizedBox(width: 8),
            MButton(
              onPressed: () {
                context.read<CheckoutCN>().deleteSelection();
              },
              title: "Delete Selection",
            ),
            const Spacer(),
            MButton(
              onPressed: () {
                if (context.read<DownloadCN>().downloadPath.isEmpty) {
                  // show alertdialog
                  showDialog(
                    context: context,
                    builder: (context) => const MAlertDialogNoDownloadPath(),
                  );
                } else {
                  final Set<CheckoutItem> selection =
                      context.read<CheckoutCN>().selected;
                  context.read<DownloadCN>().addDownloads(selection);

                  ScaffoldMessenger.of(globalContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${selection.length} papers added to download queue.",
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

                  context.read<CheckoutCN>().deleteSelection();
                }
              },
              title: "Download Selection",
              primary: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: MBoxDec.largeBoxDecoration,
          child: Column(
            children: [
              const CheckoutTableHeader(),
              if (checkoutItems.isEmpty)
                const NoCheckoutPlaceholder(),
              for (final (i, item) in checkoutItems.indexed)...[
                CheckoutEntryRow(
                  item: item,
                  documentType: "Document",
                  isSelected: context
                      .watch<CheckoutCN>()
                      .selected
                      .contains(item),
                  isLast: i == checkoutItems.length - 1,
                ),
              ]
              ,
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutEntryRow extends StatelessWidget {
  const CheckoutEntryRow({
    super.key,
    required this.item,
    required this.documentType,
    this.isLast = false,
    this.isSelected = false,
  });
  final CheckoutItem item;
  final String documentType;
  final bool isLast;
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
      onPressed: () {
        context.read<CheckoutCN>().toggleSelected(item);
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
                item.name,
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
            SizedBox(
              width: 28,
              height: 28,
              child: RawMaterialButton(
                onPressed: () {
                  showPdfPreview(
                    context,
                    item.name,
                    item.getItemUrl(),
                  );
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
        ),
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

class CheckoutTableHeader extends StatelessWidget {
  const CheckoutTableHeader({
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Document name',
              style: MTextStyles.xsMdGrey500,
            ),
          ),
          Expanded(
            child: Text(
              'Document type',
              style: MTextStyles.xsMdGrey500,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class NoCheckoutPlaceholder extends StatelessWidget {
  const NoCheckoutPlaceholder({
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
              artboard: 'empty checkout',
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 8,
            width: double.infinity,
          ),
          Text(
            'Nothing to checkout',
            style: MTextStyles.mdMdGrey900,
          ),
          const SizedBox(
            height: 4,
            width: double.infinity,
          ),
          Text(
            "Seems like you haven't added any documents to checkout.",
            style: MTextStyles.smRgGrey500,
          ),
        ],
      ),
    );
  }
}
