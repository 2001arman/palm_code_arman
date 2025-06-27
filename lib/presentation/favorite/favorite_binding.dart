import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/favorite/favorite_logic.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteLogic());
  }
}
