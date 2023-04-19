import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.onPressed,
      this.isLogout = false})
      : super(key: key);
  final String title;
  final String description;
  final Function() onPressed;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title),
      content: Text(description),
      actions: [
        isLogout
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              )
            : Container(),
        isLogout
            ? TextButton(
                onPressed: onPressed,
                child: const Text('Yes'),
              )
            : TextButton(
                onPressed: onPressed,
                child: const Text('Ok'),
              ),
      ],
    );
  }
}

// void showCustomDialog(ctx, title, description, onPressed) {
//   showDialog(
//     context: ctx,
//     builder: (context) => AlertDialog(
//       title: Text(title),
//       content: Text(description),
//       actions: [
//         TextButton(
//           onPressed: onPressed,
//           child: const Text('Ok'),
//         )
//       ],
//     ),
//   );
// }
