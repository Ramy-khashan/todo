import 'package:flutter/material.dart';
import 'package:todo/constant/colors.dart';

class TaskShapeItem extends StatelessWidget {
  final String task;
  final Function(dynamic val) onClick;
  final Function()? onFavorite;
  final Size size;
  final bool isDone;
  final bool isNeedFavorite;
  final int isFavorite;
  final String color;

  const TaskShapeItem(
      {Key? key,
      required this.color,
      required this.task,
      required this.onClick,
      required this.size,
      required this.isDone,
      this.isNeedFavorite = true,
      required this.isFavorite,
      this.onFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isDone,
        onChanged: onClick,
        activeColor: Color(int.parse(color)),
        fillColor: MaterialStateProperty.all(Color(int.parse(color))),
      ),
      title: Text(
        task,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: size.shortestSide * .045),
      ),
      trailing: IconButton(
          onPressed: onFavorite,
          icon: Icon(
            isNeedFavorite
                ? (isFavorite == 0
                    ? Icons.favorite_border
                    : Icons.favorite_rounded)
                : Icons.delete,
            color: isNeedFavorite ? OwnColor.mainColor : Colors.red.shade600,
          )),
    );
  }
}
