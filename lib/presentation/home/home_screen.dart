import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';

class HomeScreen extends StatelessWidget {
  static String namePath = "/home_screen";
  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: [
          // app bar
          SliverAppBar(
            title: Text('Palm Code Test Arman'),
            actions: [Icon(Icons.favorite_border), SizedBox(width: 20)],
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => TextField(
                        controller: state.searchController,
                        onChanged: (value) => state.search.value = value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search books",
                          suffixIcon: state.search.value != ""
                              ? IconButton(
                                  onPressed: () {
                                    state.searchController.text = "";
                                    state.search.value = "";
                                  },
                                  icon: Icon(Icons.clear),
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          // content
          Obx(
            () => SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: state.isLoading.value
                  ? SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.51,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => CardItem(book: state.books[index]),
                        childCount: state.books.length,
                      ),
                    ),
            ),
          ),
          Obx(
            () => SliverToBoxAdapter(
              child: state.isLoadingMore.value
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
