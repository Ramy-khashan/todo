import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import 'head.dart';

class GetTitleItem extends StatelessWidget {
  final String head;
  final String align;
  final Function(String val) onValid;
  final TextEditingController controller;
  final Function(dynamic val) onChange;
  final Size size;

  const GetTitleItem(
      {Key? key,
      required this.onChange,
      required this.align,
      required this.onValid,
      required this.controller,
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
          height: size.longestSide * .075,
          decoration: BoxDecoration(
              color: OwnColor.addTaskFieldsColor,
              borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            validator: (String? val) {
              return onValid(val!);
            },
            textAlign: align == "en" ? TextAlign.left : TextAlign.right,
            style: Theme.of(context).textTheme.headline6,
            controller: controller,
            onChanged: onChange,
            decoration: InputDecoration(
              hintText: "Write task here..",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
