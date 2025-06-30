import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: state.favorites.isEmpty
            ? EmptyInfo()
            : DynamicHeightGridView(
                itemCount: state.favorites.length,
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                builder: (context, index) => CardItem(
                  book: state.favorites[index],
                  onFavoriteBook: logic.favoriteBookAction,
                  isFavorite: state.favorites[index].isFavorite ?? true.obs,
                ),
              ),
      ),
    );
  }
}
