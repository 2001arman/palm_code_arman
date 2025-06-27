import 'package:get/instance_manager.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
  }
}
