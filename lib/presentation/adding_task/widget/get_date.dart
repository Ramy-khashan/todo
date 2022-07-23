import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import 'head.dart';

class GetDateItem extends StatelessWidget {
  final String head;
  final String date;

  final Function() ontap;
  final Size size;
  const GetDateItem(
      {Key? key,
      required this.date,
      required this.head,
      required this.ontap,
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
          child: Row(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              IconButton(
                  onPressed: ontap,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined))
            ],
          ),
        ),
      ],
    );
  }
}
