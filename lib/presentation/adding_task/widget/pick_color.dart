import 'package:flutter/material.dart';

class PickColorItem extends StatelessWidget {
  final Size size;
  final VoidCallback onChangeBG;
  final VoidCallback onChangeText;
  final Color colorBg;
  final Color colorText;

  const PickColorItem(
      {Key? key,
      required this.onChangeBG,
      required this.onChangeText,
      required this.size,
      required this.colorBg,
      required this.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.shortestSide * .03,
          vertical: size.longestSide * .015),
      child: Row(
        children: [
          InkWell(
            onTap: onChangeBG,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorBg,
                  
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "BG color",
                  style: TextStyle(
                      fontSize: size.shortestSide * .05,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onChangeText,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorText,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Text color",
                  style: TextStyle(
                      fontSize: size.shortestSide * .05,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
