import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:past_paper_master/components/twotones.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/textstyle.dart';

class MButton extends StatelessWidget {
  const MButton({
    required this.onPressed,
    this.title = 'Button',
    this.primary = false,
    this.height,
    this.disabled = false,
    super.key,
  });

  final void Function()? onPressed;
  final String title;
  final bool primary;
  final bool disabled;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: disabled ? null : onPressed,
      constraints: const BoxConstraints(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: primary
          ? (disabled ? MColors.accent.shade400 : MColors.accent.shade500)
          : (disabled ? MColors.grey.shade100 : MColors.white),
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
              : Border.all(color: MColors.grey.shade300),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: primary ? MColors.white : MColors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MButtonGroup extends StatefulWidget {
  const MButtonGroup({
    super.key,
    required this.titles,
    required this.onPressed,
    required this.selected,
  });

  final List<String> titles;
  final Function(BuildContext, int) onPressed;
  final int selected;

  @override
  State<MButtonGroup> createState() => _MButtonGroupState();
}

class _MButtonGroupState extends State<MButtonGroup> {
  int selected = 0;

  _MButtonGroupState();

  @override
  Widget build(BuildContext context) {
    selected = widget.selected;
    return Row(
      children: [
        for (final (i, title) in widget.titles.indexed)
          RawMaterialButton(
            onPressed: () {
              setState(() {
                selected = i;
                widget.onPressed(context, i);
              });
            },
            constraints: const BoxConstraints(),
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
              ),
            ),
            fillColor: selected == i ? MColors.accent.shade500 : MColors.white,
            elevation: selected == i ? 1 : 0.5,
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
                border: selected == i
                    ? Border.all(
                        color: MColors.accent.shade500,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      )
                    : Border.all(
                        color: MColors.grey.shade300,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: selected == i ? MColors.white : MColors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MLongButton extends StatelessWidget {
  const MLongButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.placeholder = false,
    required this.iconName,
    this.size = 20,
  });

  final void Function()? onPressed;
  final String title;
  final String iconName;
  final bool placeholder;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints(),
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
          border: Border.all(color: MColors.grey.shade300),
        ),
        child: Row(
          children: [
            twoToneIcon(iconName, false, width: size, height: size),
            const SizedBox(width: 8),
            Expanded(
              flex: 99,
              child: Text(
                title,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: placeholder
                      ? MColors.grey.shade500
                      : MColors.grey.shade900,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Ionicons.chevron_forward_outline,
              color: MColors.grey.shade500,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class MLongDropdownButton extends StatefulWidget {
  const MLongDropdownButton({
    super.key,
    required this.title,
    required this.iconName,
    required this.size,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String iconName;
  final double size;
  final List<String> items;
  final String? value;
  final Function(BuildContext, String?) onChanged;

  @override
  State<MLongDropdownButton> createState() => _MLongDropdownButtonState();
}

class _MLongDropdownButtonState extends State<MLongDropdownButton> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? selectedValue = widget.value;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(

        isExpanded: true,
        customButton: RawMaterialButton(
          onPressed: null,
          constraints: const BoxConstraints(),
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
              border: Border.all(color: MColors.grey.shade300),
            ),
            child: Row(
              children: [
                twoToneIcon(
                  widget.iconName,
                  false,
                  width: widget.size,
                  height: widget.size,
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 99,
                  child: Text(
                    selectedValue ?? widget.title,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: selectedValue == null
                          ? MColors.grey.shade500
                          : MColors.grey.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Ionicons.chevron_forward_outline,
                  color: MColors.grey.shade500,
                  size: 16,
                ),
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
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: MTextStyles.mdRgGrey900),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            widget.onChanged(context, value as String?);
          });
        },
        buttonStyleData: const ButtonStyleData(height: 40),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
        dropdownStyleData: DropdownStyleData(
          elevation: 0,
          maxHeight: 360,
          padding: const EdgeInsets.only(bottom: 6),

          decoration: BoxDecoration(
            color: MColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MColors.grey.shade200),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19101828),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Color(0x10101828),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40),


      dropdownSearchData: DropdownSearchData(
        searchInnerWidgetHeight: 20,
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
            style: MTextStyles.mdMdGrey900,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
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
          return item.value
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },

      )
      ),
    );
  }
}

class MLongComboDropdownButton extends StatefulWidget {
  const MLongComboDropdownButton({
    super.key,
    required this.title,
    required this.iconName,
    required this.size,
    required this.items,
    required this.onChanged,
    required this.initValue,
    this.fieldName = 'item',
  });

  final String title;
  final String iconName;
  final double size;
  final List<String> items;
  final Function(BuildContext, String?) onChanged;
  final List<String> initValue;
  final String fieldName;

  @override
  State<MLongComboDropdownButton> createState() =>
      _MLongComboDropdownButtonState();
}

class _MLongComboDropdownButtonState extends State<MLongComboDropdownButton> {
  // final TextEditingController textEditingController = TextEditingController();

  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> selectedValue = widget.initValue;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        // FIXME: Fix this:
        // scrollbarAlwaysShow: true,

        customButton: RawMaterialButton(
          onPressed: null,
          constraints: const BoxConstraints(),
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
              border: Border.all(color: MColors.grey.shade300),
            ),
            child: Row(
              children: [
                twoToneIcon(
                  widget.iconName,
                  false,
                  width: widget.size,
                  height: widget.size,
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 99,
                  child: Text(
                    selectedValue.isEmpty
                        ? widget.title
                        : "${selectedValue.length} ${widget.fieldName}${selectedValue.length == 1 ? '' : 's'} selected",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: selectedValue.isEmpty
                          ? MColors.grey.shade500
                          : MColors.grey.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Ionicons.chevron_forward_outline,
                  color: MColors.grey.shade500,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        items: widget.items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                enabled: false,
                child: StatefulBuilder(
                  builder: (_, menuSetState) {
                    bool isSelected = selectedValue.contains(item);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                          widget.onChanged(context, item);
                        });
                        menuSetState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check, size: 20)
                            else
                              Container(
                                width: 20,
                              ),
                            const SizedBox(
                              width: 8,
                              height: double.infinity,
                            ),
                            Text(item, style: MTextStyles.mdRgGrey900),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
        value: selectedValue.isEmpty ? null : selectedValue.last,
        // FIXME: Fix this
        // selectedItemHighlightColor: MColors.transparent,
        onChanged: (value) {},
        buttonStyleData: const ButtonStyleData(
          height: 40,
        ),
        dropdownStyleData: DropdownStyleData(
          scrollbarTheme: ScrollbarThemeData(
            // I think this does the right thing...
            thumbVisibility: WidgetStateProperty.all(true)
          ),
          elevation: 0,
          padding: const EdgeInsets.only(bottom: 6),
          maxHeight: 360,
          decoration: BoxDecoration(
            color: MColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MColors.grey.shade200),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19101828),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Color(0x10101828),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
          ],
        ),
      ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.zero
        ),



        onMenuStateChange: (isOpen) {},
      ),
    );
  }
}
