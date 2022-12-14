
import 'package:flutter/material.dart';
import 'package:ltcapp/core/config/Globals.dart';


class TopContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets? padding;
  final Color color;

  const TopContainer({Key? key, this.height, this.width, this.padding, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding != null ? padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        )
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
