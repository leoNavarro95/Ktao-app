import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:preferencias_de_usuario/models/user_model.dart';
import 'package:preferencias_de_usuario/src/controllers/home_controller.dart';

class HomeList extends StatelessWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'users',
      builder: (_) {
        if (_.loading) {
          return Center(child: LinearProgressIndicator());
        } else {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final User user = _.users[index];
              return ListTile(
                title: Text(user.firstName),
                subtitle: Text(user.email),
                onTap: (){
                  return _.showUserProfile(user);
                },
              );
            },
            itemCount: _.users.length,
          );
        }
      },
    );
  }
}
