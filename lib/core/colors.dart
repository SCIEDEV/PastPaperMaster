import 'package:flutter/material.dart';

class MColors {
  static const Color transparent = Color(0x00000000);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const MaterialColor red = MaterialColor(
    0xFFF04438,
    <int, Color>{
      50: Color(0xFFFEF3F2),
      100: Color(0xFFFEE4E2),
      200: Color(0xFFFECDCA),
      300: Color(0xFFFDA29B),
      400: Color(0xFFF97066),
      500: Color(0xFFF04438),
      600: Color(0xFFD92D20),
      700: Color(0xFFB42318),
      800: Color(0xFF912018),
      900: Color(0xFF7A271A),
    },
  );

  static const MaterialColor accent = red;

  // [Colors.grey] has not been renamed to [Colors.gray] yet due to
  // compatibility concerns.
  // See https://github.com/flutter/flutter/issues/24722
  static const MaterialColor grey = MaterialColor(
    0xFF667085,
    <int, Color>{
      50: Color(0xFFF9FAFB),
      100: Color(0xFFF2F4F7),
      200: Color(0xFFE4E7EC),
      300: Color(0xFFD0D5DD),
      400: Color(0xFF98A2B3),
      500: Color(0xFF667085),
      600: Color(0xFF475467),
      700: Color(0xFF344054),
      800: Color(0xFF1D2939),
      900: Color(0xFF101828),
    },
  );
}
