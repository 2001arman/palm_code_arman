import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';
import 'package:palm_code_arman/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:palm_code_arman/presentation/widgets/empty_info.dart';

class FavoriteScreen extends StatelessWidget {
  static const String namePath = "/favorite_screen";
  final logic = Get.find<FavoriteLogic>();
  final state = Get.find<FavoriteLogic>().state;
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: [
          // app bar
          CustomSliverAppBar(
            searchController: state.searchController,
            onSearchChange: logic.searchBooks,
            searchHint: "Search favorite books",
            title: "Favorites",
          ),

          // content
          Obx(
            () => SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: state.isLoading.value
                  ? SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : state.books.isEmpty
                  ? SliverToBoxAdapter(child: EmptyInfo())
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.45,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => CardItem(book: state.books[index]),
                        childCount: state.books.length,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
