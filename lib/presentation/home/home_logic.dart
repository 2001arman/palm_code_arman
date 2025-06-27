import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeLogic extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxString search = ''.obs;
}
