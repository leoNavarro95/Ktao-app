import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/routes/app_routes.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/theme/theme_services.dart';

class MenuLateral extends StatelessWidget {
  final double _iconsSize = 40.0;
  final menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {

  const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
]);
    final textTheme = Get.theme.textTheme;

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),           
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/electric_meter.jpeg',
                      ),
                      colorFilter: ThemeService().isSavedDarkMode() ? greyscale : ColorFilter.srgbToLinearGamma(),
                      fit: BoxFit.cover),
                ),
              ),
              menuHeader(),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.blue,
                  size: _iconsSize,
                ),
                title: Text('Inicio', style: textTheme.bodyText2,),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
                onTap: () {
                  // Navigator.pushReplacementNamed(context, HomePage.routeName);
                  Get.offNamed(AppRoutes.HOME);
                  // Get.back();
                  // Get.toNamed(AppRoutes.HOME);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: _iconsSize,
                ),
                title: Text('Detalles', style: textTheme.bodyText2,),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
                onTap: () {
                  // Navigator.pushReplacementNamed(context, CalculadorasMainPage.routeName);
                  Get.offNamed(AppRoutes.DETAIL);
                  // Get.back();
                  // Get.toNamed(AppRoutes.DETAIL);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.calculate,
                  color: Colors.blue,
                  size: _iconsSize,
                ),
                title: Text('Calculadora de consumo', style: textTheme.bodyText2,),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
            ),
            onTap: () {
              // Navigator.pushReplacementNamed(context, HomePage.routeName);
              Get.offNamed(AppRoutes.CALCULADORA);
              // Get.back();
              // Get.toNamed(AppRoutes.CALCULADORA);
            },
          ),
        ],
      ),
    );
  }

  Widget menuHeader() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ktao App", style: Get.theme.textTheme.headline6,),
                Divider(indent: 20,)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: changeThemeButton(),
        ),
      ],
    );
  }

  Widget changeThemeButton() {
    final IconData _icon = ThemeService().isSavedDarkMode()
        ? Icons.wb_sunny_rounded
        : Icons.brightness_3_rounded;
    return Transform.rotate(
      angle: pi / 5.0,
      child: Roulette(
        spins: 2,
        duration: const Duration( milliseconds: 3000 ),
        manualTrigger: true,
        controller: (ctr) => menuController.animationController = ctr,
        child: IconButton(
          icon: Icon(_icon),
          iconSize: 30,
          onPressed: () async{
            ThemeService().changeThemeMode();
            await Future.delayed(Duration(milliseconds: 500), (){
              menuController.animationController.forward(from: 0.0);
            });
          },
        ),
      ),
    );
  }
}

class MenuController extends GetxController{

  AnimationController _animationController;

  AnimationController get animationController => this._animationController;

  set animationController(AnimationController animationController) {
    this._animationController = animationController;
  }


}