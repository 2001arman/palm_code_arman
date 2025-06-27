import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:palm_code_arman/presentation/detail/detail_binding.dart';
import 'package:palm_code_arman/presentation/detail/detail_screen.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_binding.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_screen.dart';
import 'package:palm_code_arman/presentation/home/home_binding.dart';
import 'package:palm_code_arman/presentation/home/home_screen.dart';

class AppRoute {
  static String initialRoute = HomeScreen.namePath;
  static final routes = [
    GetPage(
      name: HomeScreen.namePath,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: DetailScreen.namePath,
      page: () => DetailScreen(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: FavoriteScreen.namePath,
      page: () => FavoriteScreen(),
      binding: FavoriteBinding(),
    ),
  ];
}
