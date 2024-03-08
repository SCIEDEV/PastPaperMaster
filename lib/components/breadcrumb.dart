import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:provider/provider.dart';

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RawMaterialButton(
          onPressed: () {
            context.read<BrowseCN>().path = [];
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
          child: Icon(
            FeatherIcons.home,
            color: MColors.grey.shade500,
            size: 20,
          ),
        ),
        const SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        const SizedBox(width: 4),
        for (var i = 0; i < context.watch<BrowseCN>().path.length; i++) ...[
          RawMaterialButton(
            onPressed: () {
              context.read<BrowseCN>().path =
                  context.read<BrowseCN>().path.sublist(0, i + 1);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              context.watch<BrowseCN>().path[i],
              style: MTextStyles.smMdGrey500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            FeatherIcons.chevronRight,
            color: MColors.grey.shade300,
            size: 16,
          ),
          const SizedBox(width: 4),
        ],
      ],
    );
  }
}
