import 'package:flutter/material.dart';

class SubjectItem extends StatelessWidget {
  final String subject;
  const SubjectItem({super.key, required this.subject});

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
        subject,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
