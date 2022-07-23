import 'package:flutter/material.dart';
import 'package:todo/constant/colors.dart';

class CurrentDayITem extends StatelessWidget {
  final Size size;
  final String dayName;
  final String dayNum;
  final bool isToday;
  const CurrentDayITem({
    Key? key,
    required this.dayName,
    required this.dayNum,
    required this.isToday,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.longestSide * .11,
        margin: EdgeInsets.symmetric(
            horizontal: size.shortestSide * .02,
            vertical: size.longestSide * .02),
        padding: EdgeInsets.symmetric(
          vertical: size.longestSide * .015,
          horizontal: size.shortestSide * .036,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isToday ? OwnColor.mainColor : Colors.transparent),
        child: DefaultTextStyle(
          style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: size.shortestSide * .045),
          child: Column(
            children: [Text(dayName), const Spacer(), Text(dayNum)],
          ),
        ));
  }
}
