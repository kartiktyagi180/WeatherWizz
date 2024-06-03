import 'package:flutter/material.dart';

class HourlyForecastItems extends StatelessWidget {
 final IconData icon;
  final String time;
  final String temp;

  const HourlyForecastItems({
    required this.time,
    required this.icon,
    required this.temp,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 120,
                height: 120,
                child: Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 12, 26, 33),
                 child: Padding(
                  padding: const EdgeInsets.all(9),
              child: Column(
                    children: [ 
                               Text(time, style: const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold,),),
                                 const SizedBox(width: 00, height: 2),
                                   Icon(icon, size: 30, color: Colors.white),
                                  const SizedBox(width: 00, height: 6),
                                  Text('$temp K', style: const TextStyle(color:  Colors.white, fontSize: 17),), 
                    ]
                     ),
                 )
                ),
              );
  }
  }
