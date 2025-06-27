import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/detail/detail_logic.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailLogic());
    Get.lazyPut(() => HomeLogic());
  }
}
