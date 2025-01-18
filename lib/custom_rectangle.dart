import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {
  final String text;
  final Icon icon;
  final int number;

  // Default values
  const CustomRectangle({
    Key? key,
    this.text = "Default Text", // Default text
    this.icon = const Icon(Icons.star), // Default icon
    this.number = 42, // Default number
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 120, // Breadth of the rectangle
      height: 200, // Length of the rectangle (smaller than breadth)
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10), // Optional rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Centered Text
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Bottom Left Icon
          Positioned(
            bottom: 8,
            left: 8,
            child: icon,
          ),
          // Bottom Right Number
          Positioned(
            bottom: 8,
            right: 8,
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
