import 'package:flutter/material.dart';

class hourforcast extends StatelessWidget {
  final String time;
  final String temp;
  final IconData win;
  const hourforcast({super.key,
  required this.time,
  required this.temp,
  required this.win,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  win,
                  size: 32,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  temp,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
