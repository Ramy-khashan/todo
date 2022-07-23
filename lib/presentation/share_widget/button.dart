import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String head;
  final VoidCallback onPress;
  final Size size;
  final Color color;
  final bool isNeedMargin;
  const ButtonItem(
      {Key? key,
      required this.head,
      required this.onPress,
      required this.size,
      this.isNeedMargin = true,
      this.color = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.longestSide * .019),
        width: double.infinity,
        margin: isNeedMargin
            ? EdgeInsets.symmetric(horizontal: size.shortestSide * .05)
            : EdgeInsets.symmetric(vertical: size.longestSide * .025),
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
