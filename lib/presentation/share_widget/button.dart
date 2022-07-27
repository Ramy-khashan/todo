import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String head;
  final VoidCallback onPress;
  final Size size;
  final Color color;
  final double paddingSize;
  const ButtonItem(
      {Key? key,
      required this.head,
      this.paddingSize=.02,
      required this.onPress,
      required this.size,
      this.color = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.longestSide * paddingSize),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: size.shortestSide * .05,
            vertical: size.longestSide * .02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: color.withOpacity(.9)),
        child: Text(
          head,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: size.shortestSide * .05,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
