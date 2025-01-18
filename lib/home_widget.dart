import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  final String name;
  final int? count;
  final IconData? icon;
  final VoidCallback? onPressed;

  const HomeWidget({
    required this.name,
    this.count,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 5),
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (icon != null) 
                Icon(icon, size: 30, color: Colors.white),
              SizedBox(width: 10), // Reduced width between icon and name
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              if (count != null)
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}