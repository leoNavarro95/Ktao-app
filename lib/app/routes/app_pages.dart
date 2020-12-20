import 'package:get/route_manager.dart';
import 'package:healthCalc/app/modules/detail/detail_binding.dart';
import 'package:healthCalc/app/modules/detail/detail_page.dart';

import 'package:healthCalc/app/modules/splash/splash_page.dart';
import 'package:healthCalc/app/routes/app_routes.dart';
import 'package:healthCalc/app/modules/splash/splash_binding.dart';
import 'package:healthCalc/app/modules/home/home_page.dart';
import 'package:healthCalc/app/modules/home/home_binding.dart';


//* Se va a manejar una lista con todas las paginas, sus nombres y bindigs (dependencias) 
class AppPages{
  static final List<GetPage> pages = [

    GetPage(
      name:    AppRoutes.SPLASH, 
      page:    ()=> SplashPage(), 
      binding: SplashBinding(),
    ),

    GetPage(
      name:    AppRoutes.HOME, 
      page:    ()=> HomePage(), 
      binding: HomeBinding(),
    ),

    GetPage(
      name:    AppRoutes.DETAIL, 
      page:    ()=> DetailPage(), 
      binding: DetailBinding()),

  ];
}