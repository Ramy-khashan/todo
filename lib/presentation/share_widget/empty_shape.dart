import 'package:flutter/material.dart';

class EmptyShape extends StatelessWidget {
  final String head;
  final Size size;
  const EmptyShape({Key? key, required this.head, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        head,
        style: TextStyle(
            fontSize: size.shortestSide * .09,
            fontWeight: FontWeight.w800,
            color: Colors.grey.shade400,
            fontFamily: "emptyfont"),
      ),
    );
  }
}
