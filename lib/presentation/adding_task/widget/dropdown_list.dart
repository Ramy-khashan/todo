import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import 'head.dart';

class DropDownListItem extends StatelessWidget {
  final String reminderValue;
  final String head;
  final Size size;
  final List<String> listType;
  final Function(dynamic value) onChange;
  const DropDownListItem(
      {Key? key,
      required this.onChange,
      required this.listType,
      required this.reminderValue,
      required this.head,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadItem(
          head: head,
          size: size,
        ),
        Container(
          height: size.longestSide * .09,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: OwnColor.addTaskFieldsColor,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: DropdownButton<String>(
              isExpanded: true,
              underline: Container(color: Colors.transparent),
              value: reminderValue,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              style: Theme.of(context).textTheme.headline6,
              onChanged: onChange,
              items: listType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
