import 'package:flutter/material.dart';

class RestaurantImageWidget extends StatelessWidget {
  const RestaurantImageWidget({Key? key, required this.restaurantName})
      : super(key: key);
  final String restaurantName;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/resaurant1.jpg')),
        Text(
          restaurantName,
          style: const TextStyle(
            shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
