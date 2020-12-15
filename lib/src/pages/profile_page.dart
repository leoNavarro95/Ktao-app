import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';

import 'package:preferencias_de_usuario/src/controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${_.user.firstName} ${_.user.lastName}'),

                  SizedBox(height: 10),

                  CupertinoTextField(
                    textAlign: TextAlign.center,
                    onChanged: _.onTextFieldChanged,
                  ), //OJO diseno de IOS

                  SizedBox(height: 10),

                  CupertinoButton(
                    child: Text('Aceptar'),
                    onPressed: _.goToBackWithData,
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ));
  }
}
