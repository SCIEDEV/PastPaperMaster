import 'package:flutter/material.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:past_paper_master/colors.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RawMaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
            child: Icon(FeatherIcons.home,
                color: MColors.grey.shade500, size: 20)),
        const SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        const SizedBox(width: 4),
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Mathematics (9709)',
            style: MTextStyles.smMdGrey500,
          ),
        ),
        const SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        const SizedBox(width: 4),
        RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '2013',
            style: MTextStyles.smMdAccent700,
          ),
        ),
        const SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        const SizedBox(width: 4),
      ],
    );
  }
}
