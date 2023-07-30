import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 20,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
