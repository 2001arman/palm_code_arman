import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/detail/detail_logic.dart';
import 'package:palm_code_arman/presentation/widgets/subject_item.dart';

class DetailScreen extends StatelessWidget {
  static const String namePath = "/detail_screen";
  final logic = Get.find<DetailLogic>();
  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Fielding, Henry"),
        backgroundColor: Colors.white,
        actions: [Icon(Icons.favorite_border), SizedBox(width: 20)],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Image.network(
            "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg",
            height: 300,
          ),
          const SizedBox(height: 10),
          Text(
            "History of Tom Jones, a Foundling",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [SubjectItem(), SubjectItem(), SubjectItem()],
              ),
            ),
          ),
          Text(
            "\"The Adventures of Ferdinand Count Fathom\" by Tobias Smollett is a satirical novel written in the mid-18th century. The narrative follows the cunning and morally ambiguous character of Ferdinand Count Fathom, a man of mysterious parentage armed with an extraordinary talent for deception and manipulation. The story sets the stage for themes of vice and virtue, exploring Fathom’s escapades and schemes as he navigates a world ripe for exploitation.  The opening of the novel introduces Fathom in an unusual light—born under strange circumstances to a mother who flitted between roles in military encampments and armies. We explore the early influence of his mother, an adventurous and fierce figure whose exploits paint a picture of a wild and unrestrained environment. As Fathom grows, he exhibits a blend of charisma and villainy, drawing the attention of powerful patrons while developing ambitions of his own. With a sharp wit and an ability to adapt, he becomes both an object of admiration and contempt, preparing the reader for a complex journey through deceit, ambition, and the nature of morality. (This is an automatically generated summary.)",
            style: TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
