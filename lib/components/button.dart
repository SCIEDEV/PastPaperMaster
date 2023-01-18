import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/components/twotones.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:past_paper_master/textstyle.dart';

class MButton extends StatelessWidget {
  const MButton(
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
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: primary ? MColors.accent.shade500 : MColors.white,
      elevation: primary ? 1 : 0.5,
      highlightElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
              bottomLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
              topRight: i == widget.titles.length - 1
                  ? const Radius.circular(8)
                  : Radius.zero,
              bottomRight: i == widget.titles.length - 1
                  ? const Radius.circular(8)
                  : Radius.zero,
            )),
            fillColor: _selected == i ? MColors.accent.shade500 : MColors.white,
            elevation: _selected == i ? 1 : 0.5,
            highlightElevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
                  bottomLeft: i == 0 ? const Radius.circular(8) : Radius.zero,
                  topRight: i == widget.titles.length - 1
                      ? const Radius.circular(8)
                      : Radius.zero,
                  bottomRight: i == widget.titles.length - 1
                      ? const Radius.circular(8)
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
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: MColors.white,
      elevation: 0.5,
      highlightElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
            const Spacer(),
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

class MLongDropdownButton extends StatefulWidget {
  const MLongDropdownButton(
      {super.key,
      required this.title,
      required this.iconName,
      required this.size,
      required this.items});

  final String title;
  final String iconName;
  final double size;
  final List<String> items;

  @override
  State<MLongDropdownButton> createState() => _MLongDropdownButtonState();
}

class _MLongDropdownButtonState extends State<MLongDropdownButton> {
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        customButton: RawMaterialButton(
          onPressed: null,
          constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: MColors.white,
          elevation: 0.5,
          disabledElevation: 0.5,
          highlightElevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MColors.grey.shade300, width: 1),
            ),
            child: Row(
              children: [
                twoToneIcon(widget.iconName, false,
                    width: widget.size, height: widget.size),
                const SizedBox(width: 8),
                Text(
                  selectedValue == null ? widget.title : selectedValue!,
                  style: TextStyle(
                      color: selectedValue == null
                          ? MColors.grey.shade500
                          : MColors.grey.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Icon(
                  Ionicons.chevron_forward_outline,
                  color: MColors.grey.shade500,
                  size: 16,
                )
              ],
            ),
          ),
        ),
        hint: Text(
          'Select subject',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: MTextStyles.mdRgGrey900),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonHeight: 40,
        dropdownElevation: 0,
        itemHeight: 40,
        dropdownMaxHeight: 360,
        dropdownDecoration: BoxDecoration(
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
        searchController: textEditingController,
        searchInnerWidget: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Type here to search...',
              hintStyle: MTextStyles.smRgGrey500,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return (item.value
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase()));
        },
        dropdownPadding: const EdgeInsets.only(bottom: 6),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
