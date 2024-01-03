import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:undo_redo/core/theme/app_color.dart';
import 'core/route/route.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColor.mainColor,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColor.mainColor
      ),
      initialRoute: Routes.splashScreen,
    );
  }
}

