import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/presentation/home/home_logic.dart';

class HomeScreen extends StatelessWidget {
  static String namePath = "/home_screen";
  final logic = Get.find<HomeLogic>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Palm Code Test Arman")));
  }
}
