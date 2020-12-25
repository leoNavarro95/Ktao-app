import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/modules/splash/splash_binding.dart';
import 'package:healthCalc/app/modules/splash/splash_page.dart';
import 'package:healthCalc/app/routes/app_pages.dart';

void main(){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Ktao',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      // showPerformanceOverlay: true,
      
    );
  }
}
