import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widget/tap_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TapBarWidget(
                textTheme: textTheme,
                size: size,
              ),
              IndexedStack(
                index: homeController.currentIndex,
                children: homeController.tabs,
              ),
            ],
          ),
        ),
      );
    });
  }
}
