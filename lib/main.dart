import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

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
      
      title: 'Ktao',
      debugShowCheckedModeBanner: false,
      
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'), //english
        const Locale('es', 'ES'), //spanish
      ],
      
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
