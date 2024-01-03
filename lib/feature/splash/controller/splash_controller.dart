import 'package:get/get.dart';
import '../../../core/route/route.dart';

class SplashController extends GetxController {


  @override
  void onReady() {
    super.onReady();
      Future.delayed(const Duration(milliseconds: 3700), () {
        Get.offNamed(Routes.homeScreen);
      });
    }
  }
