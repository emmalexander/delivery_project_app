import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarClipRect extends CustomClipper<Path> {
  final double percent;

  SearchBarClipRect({required this.percent});

  double getRadius(double width) => percent * width;

  @override
  Rect getApproximateClipRect(Size size) {
    var radius = getRadius(size.width);
    return Rect.fromLTRB(size.width - radius, 0, radius, radius);
  }

  @override
  Path getClip(Size size) {
    var p = Path();
    p.lineTo(size.width, 0);
    p.lineTo(size.width - getRadius(size.width), 0);
    p.arcToPoint(Offset(size.width, getRadius(size.width)),
        radius: Radius.circular(getRadius(size.width)), clockwise: false);
    p.lineTo(size.width, 0);
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
