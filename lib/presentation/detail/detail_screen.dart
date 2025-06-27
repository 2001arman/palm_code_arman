import 'package:cached_network_image/cached_network_image.dart';
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
        title: Text(logic.book.authorName),
        backgroundColor: Colors.white,
        actions: [Icon(Icons.favorite_border), SizedBox(width: 20)],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CachedNetworkImage(
            imageUrl: logic.book.formats.imageJpeg,
            height: 300,
          ),
          const SizedBox(height: 10),
          Text(
            logic.book.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: logic.book.subjects
                    .map((data) => SubjectItem(subject: data))
                    .toList(),
              ),
            ),
          ),
          for (int i = 0; i < logic.book.summaries.length; i++)
            Text(
              logic.book.summaries[i],
              style: TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.justify,
            ),
        ],
      ),
    );
  }
}
