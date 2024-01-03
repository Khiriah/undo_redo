import 'package:get/get.dart';
import '../../feature/home/controller/home_controller.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
