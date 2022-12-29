import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/twotones.dart';
import 'package:ionicons/ionicons.dart';

class MButton extends StatelessWidget {
  MButton(
      {required this.onPressed,
      this.title = 'Button',
      this.primary = false,
      super.key});

  final void Function()? onPressed;
  final String title;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: primary ? MColors.accent.shade500 : MColors.white,
      elevation: primary ? 1 : 0.5,
      highlightElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: primary
              ? Border.all(color: MColors.accent.shade500, width: 0)
              : Border.all(color: MColors.grey.shade300, width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: primary ? MColors.white : MColors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class MButtonGroup extends StatefulWidget {
  const MButtonGroup({super.key, required this.titles});

  final List<String> titles;

  @override
  State<MButtonGroup> createState() => _MButtonGroupState();
}

class _MButtonGroupState extends State<MButtonGroup> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.titles.length; i++)
          RawMaterialButton(
            onPressed: () {
              setState(() {
                _selected = i;
              });
            },
            constraints: BoxConstraints(minWidth: 0, minHeight: 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: i == 0 ? Radius.circular(8) : Radius.zero,
              bottomLeft: i == 0 ? Radius.circular(8) : Radius.zero,
              topRight: i == widget.titles.length - 1
                  ? Radius.circular(8)
                  : Radius.zero,
              bottomRight: i == widget.titles.length - 1
                  ? Radius.circular(8)
                  : Radius.zero,
            )),
            fillColor: _selected == i ? MColors.accent.shade500 : MColors.white,
            elevation: _selected == i ? 1 : 0.5,
            highlightElevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: i == 0 ? Radius.circular(8) : Radius.zero,
                  bottomLeft: i == 0 ? Radius.circular(8) : Radius.zero,
                  topRight: i == widget.titles.length - 1
                      ? Radius.circular(8)
                      : Radius.zero,
                  bottomRight: i == widget.titles.length - 1
                      ? Radius.circular(8)
                      : Radius.zero,
                ),
                border: _selected == i
                    ? Border.all(
                        color: MColors.accent.shade500,
                        width: 1,
                        strokeAlign: StrokeAlign.center)
                    : Border.all(
                        color: MColors.grey.shade300,
                        width: 1,
                        strokeAlign: StrokeAlign.center),
              ),
              child: Text(
                widget.titles[i],
                style: TextStyle(
                    color:
                        _selected == i ? MColors.white : MColors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
      ],
    );
  }
}

class MLongButton extends StatelessWidget {
  const MLongButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.placeholder = false,
      required this.iconName,
      this.size = 20});

  final void Function()? onPressed;
  final String title;
  final String iconName;
  final bool placeholder;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: MColors.white,
      elevation: 0.5,
      highlightElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColors.grey.shade300, width: 1),
        ),
        child: Row(
          children: [
            twoToneIcon(iconName, false, width: size, height: size),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                  color: placeholder
                      ? MColors.grey.shade500
                      : MColors.grey.shade900,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Icon(
              Ionicons.chevron_forward_outline,
              color: MColors.grey.shade500,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
