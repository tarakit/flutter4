import 'package:flutter/material.dart';

class Cuisine extends StatelessWidget {
  const Cuisine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          width: 90,
          height: 90,
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 70,
            child: Image.asset(
              'assets/photo/soup.png',
              fit: BoxFit.contain,
            ),),),
        SizedBox(
          height: 5,
        ),
        Text('Beverages', style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }
}