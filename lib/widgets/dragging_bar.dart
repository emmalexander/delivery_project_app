import 'package:flutter/material.dart';

class DraggingBar extends StatelessWidget {
  const DraggingBar({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 50,
          height: 5,
          color: Colors.black12,
        ),
      ),
    );
  }
}
