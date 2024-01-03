import 'package:get/get.dart';
import '../../drawing_room/screen/drawing_room_screen.dart';
import '../../editing/screen/home_screen.dart';


class HomeController extends GetxController {
  int currentIndex = 0;

  List<String> items = [
    'DrawingRoomScreen',
    'Animated Builder',
  ];

  final tabs = [
     DrawingRoomScreen(),
    UploadImageScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
