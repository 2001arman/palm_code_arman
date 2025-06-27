import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';
import 'package:palm_code_arman/presentation/widgets/card_item.dart';

class HomeScreen extends StatelessWidget {
  static String namePath = "/home_screen";
  final logic = Get.find<HomeLogic>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: ScrollController(),
        slivers: [
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
                        controller: logic.searchController,
                        onChanged: (value) => logic.search.value = value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search books",
                          suffixIcon: logic.search.value != ""
                              ? IconButton(
                                  onPressed: () {
                                    logic.searchController.text = "";
                                    logic.search.value = "";
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

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => CardItem(),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
