import 'package:flutter/material.dart';
class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalInfo({
    super.key,

    required this.icon,
    required this.label,
    required this.value,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child:  Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(icon,size: 50,),
            SizedBox(height: 10 ),
            Text(label,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            Text(value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
