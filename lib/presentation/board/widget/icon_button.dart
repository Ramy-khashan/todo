import 'package:flutter/material.dart';

class IconButtonItem extends StatelessWidget {
  final IconData icon;
  final Function() onPress;
  final Size size;
  const IconButtonItem(
      {Key? key, required this.icon, required this.onPress, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPress,
        icon: Icon(
          icon,
          color: Colors.black,
        ));
  }
}
