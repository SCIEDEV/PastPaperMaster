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
            constraints: BoxConstraints(minWidth: 48, minHeight: 36),
            child: Icon(FeatherIcons.home,
                color: MColors.grey.shade500, size: 20)),
        SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        SizedBox(width: 4),
        RawMaterialButton(
          onPressed: () {},
          child: Text(
            'Mathematics (9709)',
            style: MTextStyles.sm_md_grey_500,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          constraints: BoxConstraints(minWidth: 48, minHeight: 36),
          padding: EdgeInsets.symmetric(horizontal: 4),
        ),
        SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        SizedBox(width: 4),
        RawMaterialButton(
          onPressed: () {},
          child: Text(
            '2013',
            style: MTextStyles.sm_md_accent_700,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          constraints: BoxConstraints(minWidth: 48, minHeight: 36),
          padding: EdgeInsets.symmetric(horizontal: 4),
        ),
        SizedBox(width: 4),
        Icon(FeatherIcons.chevronRight, color: MColors.grey.shade300, size: 16),
        SizedBox(width: 4),
      ],
    );
  }
}
