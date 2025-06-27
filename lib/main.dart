import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palm_code_arman/app_route.dart';
import 'package:palm_code_arman/hive_setup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBinding.initModel();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      getPages: AppRoute.routes,
      initialRoute: AppRoute.initialRoute,
    );
  }
}
