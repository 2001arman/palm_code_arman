import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_screen.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';
import 'package:palm_code_arman/presentation/widgets/custom_sliver_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const namePath = "/home_screen";
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  HomeScreen({super.key});

  Widget _buildErrorContent() {
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

  Widget _buildBookGrid() {
    return SliverDynamicHeightGridView(
      itemCount: state.books.length,
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      builder: (context, index) {
        final book = state.books[index];
        final isFavorite = state.favorites.any((f) => f.id == book.id);
        book.isFavorite?.value = isFavorite;

        return IntrinsicHeight(
          child: CardItem(
            book: book,
            isFavorite: book.isFavorite ?? false.obs,
            onFavoriteBook: logic.favoriteBookAction,
          ),
        );
      },
    );
  }

  Widget _buildLoadMoreFooter() {
    if (state.isLoadingMore.value) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.isErrorFetchMore.value) {
      return GestureDetector(
        onTap: () => logic.getMoreBook(url: state.nextPageUrl),
        child: const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Icon(Icons.replay_outlined, color: Colors.red),
        ),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          controller: state.scrollController,
          slivers: [
            CustomSliverAppBar(
              title: 'Palm Code Test Arman',
              actions: [
                GestureDetector(
                  onTap: () => Get.toNamed(FavoriteScreen.namePath),
                  child: const Icon(Icons.favorite_border),
                ),
                const SizedBox(width: 20),
              ],
              searchController: state.searchController,
              searchHint: "Search books",
              onSearchChange: logic.searchBooks,
            ),
            Obx(
              () => state.isLoading.value
                  ? const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : const SliverToBoxAdapter(child: SizedBox()),
            ),
            Obx(
              () => SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: state.isErrorFetch.value
                    ? _buildErrorContent()
                    : _buildBookGrid(),
              ),
            ),
            Obx(() => SliverToBoxAdapter(child: _buildLoadMoreFooter())),
          ],
        ),
      ),
    );
  }
}
