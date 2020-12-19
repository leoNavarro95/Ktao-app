import 'package:get/route_manager.dart';

import 'package:healthCalc/app/modules/splash/splash_page.dart';
import 'package:healthCalc/app/routes/app_routes.dart';
import 'package:healthCalc/app/modules/splash/splash_binding.dart';

//* Se va a manejar una lista con todas las paginas, sus nombres y bindigs (dependencias) 
class AppPages{
  static final List<GetPage> pages = [

    GetPage(
      name: AppRoutes.SPLASH, 
      page: ()=> SplashPage(), 
      binding: SplashBinding(),
    ),

  ];
}