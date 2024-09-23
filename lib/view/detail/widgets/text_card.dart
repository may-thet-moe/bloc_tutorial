import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, required this.message, this.icon});
  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 58, 56, 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          children: [
            if (icon != null) ...{
              Icon(
                icon,
                color: Colors.yellow,
                size: 17,
              ),
              const SizedBox(
                width: 10,
              ),
            },
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
