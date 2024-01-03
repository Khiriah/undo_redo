import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../feature/home/screen/home_screen.dart';
import '../../feature/splash/screen/splash_screen.dart';
import '../binding/binding.dart';
import '../binding/splash_binding.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: SplashScreen.new,
      binding: SplashBinding(),
    ),
  ];
}

class Routes {
  static const splashScreen = '/splash_screen';
  static const homeScreen = '/home_screen';
}
