import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/domain/models/book.dart';
import 'package:palm_code_arman/presentation/detail/detail_screen.dart';

class CardItem extends StatelessWidget {
  final Book book;
  const CardItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(DetailScreen.namePath, arguments: book),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color.fromARGB(255, 252, 240, 240),
          border: Border.all(width: 1, color: Color(0xFFFCF7F7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(book.formats.imageJpeg),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(10),
              child: Image.asset("assets/unfavorite.png", width: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.authorName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.title,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
