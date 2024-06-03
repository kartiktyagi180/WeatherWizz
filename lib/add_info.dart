import 'package:flutter/material.dart';

class AddInfoCards extends StatelessWidget {
  final IconData icon;
  final String category;
  final String temp;

  const AddInfoCards({
    required this.category,
    required this.icon,
    required this.temp,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 120,
                height: 140,
                child: Card(
                  elevation: 0,
                  color: const Color.fromARGB(255, 5, 46, 75),
                 child: Padding(
                  padding: const EdgeInsets.all(7),
              child: Column(
                    children: [ 
                                Icon(icon, size: 35, color: const Color.fromARGB(255, 0, 0, 0)),
                                  const SizedBox(width: 00, height: 2),
                                  Text(category, style: const TextStyle(color: Color.fromARGB(255, 223, 210, 210), fontSize: 17, /*fontWeight: FontWeight.bold*/),),
                                   const SizedBox(width: 00, height: 2),
                                   Text(temp, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 19, fontWeight: FontWeight.w900),)
                    ]
                     ),
                 )
                ),
              );
  }
}