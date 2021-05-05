import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';

import 'package:ktao/app/modules/splash/splash_binding.dart';
import 'package:ktao/app/modules/splash/splash_page.dart';
import 'package:ktao/app/routes/app_pages.dart';
import 'package:ktao/app/theme/theme_services.dart';
import 'package:ktao/app/theme/themes.dart';

void main() async{
  await GetStorage.init();

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
      
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),

      home: SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      // showPerformanceOverlay: true,
      
    );
  }
}
