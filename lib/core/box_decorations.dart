import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';

class MBoxDec {
  static BoxDecoration largeBoxDecoration = BoxDecoration(
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
      ]);
}
