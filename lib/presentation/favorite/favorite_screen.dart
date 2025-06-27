import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';
import 'package:palm_code_arman/presentation/widgets/empty_info.dart';

class FavoriteScreen extends StatelessWidget {
  static const String namePath = "/favorite_screen";
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Favorites"), backgroundColor: Colors.white),
      body: state.favorites.isEmpty
          ? EmptyInfo()
          : GridView(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.45,
              ),
              children: state.favorites.map((data) {
                return CardItem(
                  book: data,
                  onFavoriteBook: logic.favoriteBookAction,
                  isFavorite: data.isFavorite ?? true.obs,
                );
              }).toList(),
            ),
    );
  }
}
