import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/components/breadcrumb.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:rive/rive.dart';
import 'package:past_paper_master/core/subjects.dart';
import 'package:provider/provider.dart';
import 'package:past_paper_master/core/provider.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              context.watch<BrowseCN>().selection.isEmpty
                  ? 'Browse'
                  : '${context.watch<BrowseCN>().selection.length} selected',
              style: MTextStyles.dsmMdGrey900,
            ),
            const Spacer(),
            MButton(
              title: "Add to Checkout",
              onPressed: () {
                Set<CheckoutItem> selection =
                    context.read<BrowseCN>().selection;
                context.read<CheckoutCN>().items.addAll(selection);
              },
            ),
            const SizedBox(width: 8),
            MButton(
              title: "Download",
              onPressed: () {},
              primary: true,
            )
          ],
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
            children: [
              const BrowseTableHeader(),
              if (_getEntries(context.watch<BrowseCN>().path).isEmpty)
                const NoEntriesPlaceholder(),
              for (var i = 0, l = _getEntries(context.read<BrowseCN>().path);
                  i < l.length;
                  i++) ...[
                BrowseEntryRow(
                  entryName: l[i].name,
                  documentType: l[i].type,
                  isLast: i == l.length - 1,
                  isDocument: l[i].isDocument,
                  isSelected: context.watch<BrowseCN>().isSelected(l[i].name),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class BrowseEntry {
  final String name;
  final String type;
  final bool isDocument;
  BrowseEntry(
      {required this.name, required this.type, this.isDocument = false});
}

List<BrowseEntry> _getEntries(List<String> path) {
  if (path.isEmpty) {
    return [
      BrowseEntry(name: "IGCSE", type: "Qualification"),
      BrowseEntry(name: "A Level", type: "Qualification"),
    ];
  }
  dynamic temp;
  List<BrowseEntry> ret = [];
  if (path[0] == "IGCSE") {
    temp = igcseSubjectsMap;
    for (var i = 1; i < path.length; i++) {
      if (!temp.containsKey(path[i])) return [];
      temp = temp[path[i]];
    }
    if (temp is List) {
      for (var i = 0; i < temp.length; i++) {
        ret.add(BrowseEntry(
            name: temp[i] as String, type: "Document", isDocument: true));
      }
    } else {
      for (var i = 0; i < temp.keys.length; i++) {
        ret.add(BrowseEntry(name: temp.keys.elementAt(i), type: "Folder"));
      }
    }
    return ret;
  } else if (path[0] == "A Level") {
    temp = alevelSubjectsMap;
    for (var i = 1; i < path.length; i++) {
      if (!temp.containsKey(path[i])) return [];
      temp = temp[path[i]];
    }
    if (temp is List) {
      for (var i = 0; i < temp.length; i++) {
        ret.add(BrowseEntry(
            name: temp[i] as String, type: "Document", isDocument: true));
      }
    } else {
      for (var i = 0; i < temp.keys.length; i++) {
        if (temp.keys.elementAt(i).contains('.')) {
          ret.add(BrowseEntry(
              name: temp.keys.elementAt(i),
              type: "Document",
              isDocument: true));
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
  const BrowseEntryRow(
      {super.key,
      required this.entryName,
      required this.documentType,
      this.isLast = false,
      this.isDocument = false,
      this.isSelected = false});
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
                  bottomLeft: Radius.circular(8))
              : BorderRadius.zero),
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
                  entryName,
                  style: isSelected
                      ? MTextStyles.smMdAccent700
                      : MTextStyles.smMdGrey900,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  documentType,
                  style: MTextStyles.smRgGrey500,
                )),
            isDocument
                ? (isSelected
                    ? Icon(Icons.square_rounded,
                        color: MColors.accent.shade500, size: 16)
                    : Icon(Icons.check_box_outline_blank,
                        color: MColors.grey.shade500, size: 16))
                : Icon(FeatherIcons.chevronRight,
                    color: MColors.grey.shade500, size: 16),
          ],
        ),
      ),
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
              'Entry type',
              style: MTextStyles.xsMdGrey500,
            )),
        const SizedBox(width: 16),
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
