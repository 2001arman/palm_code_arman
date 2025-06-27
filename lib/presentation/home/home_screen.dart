import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_screen.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';
import 'package:palm_code_arman/presentation/widgets/custom_sliver_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static String namePath = "/home_screen";
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      if (state.isLoading.value) {
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (state.isErrorFetch.value) {
        return SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              state.isLoading.value = true;
              logic.getBooks();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.replay_outlined, color: Colors.red),
                SizedBox(height: 8),
                Text("Error occurred, please try again!"),
              ],
            ),
          ),
        );
      }

      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.45,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              IntrinsicHeight(child: CardItem(book: state.books[index])),
          childCount: state.books.length,
        ),
      );
    }

    Widget buildLoadMoreFooter() {
      if (state.isLoadingMore.value) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (state.isErrorFetchMore.value) {
        return GestureDetector(
          onTap: () => logic.getMoreBook(url: state.nextPageUrl),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: const Icon(Icons.replay_outlined, color: Colors.red),
          ),
        );
      }

      return const SizedBox();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: [
          // app bar
          CustomSliverAppBar(
            title: 'Palm Code Test Arman',
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(FavoriteScreen.namePath),
                child: Icon(Icons.favorite_border),
              ),
              SizedBox(width: 20),
            ],
            searchController: state.searchController,
            searchHint: "Search books",
            onSearchChange: logic.searchBooks,
          ),

          // content
          Obx(
            () => SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: buildContent(),
            ),
          ),
          Obx(() => SliverToBoxAdapter(child: buildLoadMoreFooter())),
        ],
      ),
    );
  }
}
