import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFFCF7F7),
        border: Border.all(width: 1, color: Color(0xFFFCF7F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: NetworkImage(
                  "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(10),
            child: Image.asset("assets/favorite.png", width: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fielding, Henry',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  'History of Tom Jones, a Foundling',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
