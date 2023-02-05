import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';
import 'dart:math' as math;

import 'package:past_paper_master/core/textstyle.dart';
import 'package:provider/provider.dart';
import 'package:past_paper_master/core/provider.dart';

class MRangeSlider extends StatefulWidget {
  const MRangeSlider({super.key});

  @override
  State<MRangeSlider> createState() => _MRangeSliderState();
}

class _MRangeSliderState extends State<MRangeSlider> {
  double _start = 2018;
  double _end = 2022;

  @override
  Widget build(BuildContext context) {
    _start = context.read<FilterCN>().startYear.toDouble();
    _end = context.read<FilterCN>().endYear.toDouble();
    return SliderTheme(
        data: SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
          activeTrackColor: MColors.accent,
          trackHeight: 8,
          rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 12, elevation: 2.0, pressedElevation: 1.0),
          overlayShape: SliderComponentShape.noOverlay,
          rangeValueIndicatorShape: const CustomValueIndicatorShape(),
          valueIndicatorColor: MColors.white,
          valueIndicatorTextStyle: MTextStyles.smMdGrey700,
          inactiveTrackColor: MColors.grey.shade200,
          inactiveTickMarkColor: MColors.grey.shade300,
          thumbColor: MColors.white,
        ),
        child: RangeSlider(
            values: RangeValues(_start, _end),
            min: 2000,
            max: 2022,
            divisions: 22,
            labels:
                RangeLabels(_start.round().toString(), _end.round().toString()),
            onChanged: (RangeValues newValues) {
              setState(() {
                _start = newValues.start;
                _end = newValues.end;
                context.read<FilterCN>().startYear = _start.round();
                context.read<FilterCN>().endYear = _end.round();
              });
            }));
  }
}

class CustomValueIndicatorShape extends RangeSliderValueIndicatorShape {
  const CustomValueIndicatorShape();

  static const _CustomSliderValueIndicatorPathPainter _pathPainter =
      _CustomSliderValueIndicatorPathPainter();

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    required TextPainter labelPainter,
    required double textScaleFactor,
  }) {
    assert(textScaleFactor >= 0);
    return _pathPainter.getPreferredSize(labelPainter, textScaleFactor);
  }

  @override
  double getHorizontalShift({
    RenderBox? parentBox,
    Offset? center,
    TextPainter? labelPainter,
    Animation<double>? activationAnimation,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    return _pathPainter.getHorizontalShift(
      parentBox: parentBox!,
      center: center!,
      labelPainter: labelPainter!,
      textScaleFactor: textScaleFactor!,
      sizeWithOverflow: sizeWithOverflow!,
      scale: activationAnimation!.value,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    bool? isOnTop,
    TextPainter? labelPainter,
    double? textScaleFactor,
    Size? sizeWithOverflow,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    Thumb? thumb,
  }) {
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation!.value;
    _pathPainter.paint(
      parentBox: parentBox!,
      canvas: canvas,
      center: center,
      scale: scale,
      labelPainter: labelPainter!,
      textScaleFactor: textScaleFactor!,
      sizeWithOverflow: sizeWithOverflow!,
      backgroundPaintColor: sliderTheme!.valueIndicatorColor!,
      strokePaintColor: null,
    );
  }
}

class _CustomSliderValueIndicatorPathPainter {
  const _CustomSliderValueIndicatorPathPainter();

  static const double _triangleHeight = 8.0;
  static const double _labelPadding = 16.0;
  static const double _preferredHeight = 32.0;
  static const double _minLabelWidth = 16.0;
  static const double _bottomTipYOffset = 14.0;
  static const double _preferredHalfHeight = _preferredHeight / 2;
  static const double _upperRectRadius = 8;

  Size getPreferredSize(
    TextPainter labelPainter,
    double textScaleFactor,
  ) {
    return Size(
      _upperRectangleWidth(labelPainter, 1, textScaleFactor),
      labelPainter.height + _labelPadding,
    );
  }

  double getHorizontalShift({
    required RenderBox parentBox,
    required Offset center,
    required TextPainter labelPainter,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    required double scale,
  }) {
    assert(!sizeWithOverflow.isEmpty);

    const double edgePadding = 8.0;
    final double rectangleWidth =
        _upperRectangleWidth(labelPainter, scale, textScaleFactor);
    final Offset globalCenter = parentBox.localToGlobal(center);
    final double overflowLeft =
        math.max(0, rectangleWidth / 2 - globalCenter.dx + edgePadding);
    final double overflowRight = math.max(
        0,
        rectangleWidth / 2 -
            (sizeWithOverflow.width - globalCenter.dx - edgePadding));

    if (rectangleWidth < sizeWithOverflow.width) {
      return overflowLeft - overflowRight;
    } else if (overflowLeft - overflowRight > 0) {
      return overflowLeft - (edgePadding * textScaleFactor);
    } else {
      return -overflowRight + (edgePadding * textScaleFactor);
    }
  }

  double _upperRectangleWidth(
      TextPainter labelPainter, double scale, double textScaleFactor) {
    final double unscaledWidth =
        math.max(_minLabelWidth * textScaleFactor, labelPainter.width) +
            _labelPadding * 2;
    return unscaledWidth * scale;
  }

  void paint({
    required RenderBox parentBox,
    required Canvas canvas,
    required Offset center,
    required double scale,
    required TextPainter labelPainter,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    required Color backgroundPaintColor,
    Color? strokePaintColor,
  }) {
    if (scale == 0.0) {
      return;
    }
    assert(!sizeWithOverflow.isEmpty);

    final double rectangleWidth =
        _upperRectangleWidth(labelPainter, scale, textScaleFactor);
    final double horizontalShift = getHorizontalShift(
      parentBox: parentBox,
      center: center,
      labelPainter: labelPainter,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
      scale: scale,
    );

    final double rectHeight = labelPainter.height + _labelPadding;
    final Rect upperRect = Rect.fromLTWH(
      -rectangleWidth / 2 + horizontalShift,
      -_triangleHeight - rectHeight,
      rectangleWidth,
      rectHeight,
    );

    final Path trianglePath = Path()
      ..lineTo(-_triangleHeight, -_triangleHeight)
      ..lineTo(_triangleHeight, -_triangleHeight)
      ..close();
    final Paint fillPaint = Paint()..color = backgroundPaintColor;
    final RRect upperRRect = RRect.fromRectAndRadius(
        upperRect, const Radius.circular(_upperRectRadius));
    trianglePath.addRRect(upperRRect);

    canvas.save();
    canvas.translate(center.dx, center.dy - _bottomTipYOffset);
    canvas.scale(scale, scale);
    canvas.drawShadow(
        trianglePath, const Color.fromARGB(40, 24, 40, 13), 4, true);
    if (strokePaintColor != null) {
      final Paint strokePaint = Paint()
        ..color = strokePaintColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(trianglePath, strokePaint);
    }
    canvas.drawPath(trianglePath, fillPaint);

    final double bottomTipToUpperRectTranslateY =
        -_preferredHalfHeight / 2 - upperRect.height;
    canvas.translate(0, bottomTipToUpperRectTranslateY);
    final Offset boxCenter = Offset(horizontalShift, upperRect.height / 2);
    final Offset halfLabelPainterOffset =
        Offset(labelPainter.width / 2, labelPainter.height / 2);
    final Offset labelOffset = boxCenter - halfLabelPainterOffset;
    labelPainter.paint(canvas, labelOffset);
    canvas.restore();
  }
}
