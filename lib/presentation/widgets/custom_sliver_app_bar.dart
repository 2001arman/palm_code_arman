import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final List<Widget>? actions;
  final TextEditingController searchController;
  final Function(String?) onSearchChange;
  final String searchHint, title;

  const CustomSliverAppBar({
    super.key,
    this.actions,
    required this.searchController,
    required this.onSearchChange,
    required this.searchHint,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      actions: actions,
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
              TextField(
                controller: searchController,
                onChanged: onSearchChange,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: searchHint,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
