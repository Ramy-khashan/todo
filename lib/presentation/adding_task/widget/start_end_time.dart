import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import 'head.dart';

class StartEndTimeItem extends StatelessWidget {
  final String head;
  final String time;
  final Size size;
  final VoidCallback onTap;

  const StartEndTimeItem(
      {Key? key,
      required this.head,
      required this.time,
      required this.onTap,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadItem(
            head: head,
            size: size,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: size.longestSide * .075,
            decoration: BoxDecoration(
                color: OwnColor.addTaskFieldsColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Spacer(),
                IconButton(
                    onPressed: onTap, icon: const Icon(Icons.access_time))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
