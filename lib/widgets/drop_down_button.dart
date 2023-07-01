import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:kurdistan_food_network/utils/constants.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton(
      {super.key,
      required this.items,
      required this.hint,
      required this.GetSelectedValue,
      required this.SetSelectedValue,
      this.iconData = Icons.filter_list});

  final List<String> items;
  final String hint;

  final String? Function() GetSelectedValue;
  final void Function(String? selectedValue) SetSelectedValue;

  final IconData iconData;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        barrierColor: kDropdownColor,
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              widget.iconData,
              size: 16,
              color: kPrimaryTextColor,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                widget.hint,
                style: const TextStyle(
                  fontSize: 16,
                  color: kPrimaryTextColor,
                ),
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryTextColor,
                    ),
                  ),
                ))
            .toList(),
        value: widget.GetSelectedValue(),
        onChanged: (String? value) async {
          setState(() {
            widget.SetSelectedValue(value);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 180,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: kDropdownColor),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: kBackgroundColor,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
