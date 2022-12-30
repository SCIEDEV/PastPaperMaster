import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget twoToneIcon(String name, bool accent, {double? width, double? height}) {
  return SvgPicture.asset(
    'assets/icons/$name-tt${accent ? '-primary' : '-grey500'}.svg',
    width: width,
    height: height,
  );
}
