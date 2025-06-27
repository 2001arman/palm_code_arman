import 'package:flutter/material.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 252, 240, 240),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Adventure stories",
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
