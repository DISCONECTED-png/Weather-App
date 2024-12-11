import 'package:flutter/material.dart';

class Additionalinfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String bablu;
  const Additionalinfo({super.key,
  required this.icon,
  required this.label,
  required this.bablu,});

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      Icon(icon,),
                      const SizedBox(height: 5,),
                      Text(label,style: const TextStyle(fontSize: 15),),
                      const SizedBox(height: 5,),
                      Text(bablu,style: const TextStyle(fontSize: 15),),
                      const SizedBox(height: 5,),
                    ],
                  ),
    );
  }
}