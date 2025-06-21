
import 'package:flutter/material.dart';

class ForcastView extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;


  const ForcastView({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child:Container(
        width: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8),
            Icon(icon,size: 32),
            SizedBox(height: 8),
            Text(temperature),
          ],
        ),
      ),
    );

  }
}