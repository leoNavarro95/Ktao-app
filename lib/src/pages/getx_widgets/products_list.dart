import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/models/producto_model.dart';
import 'package:healthCalc/src/controllers/global_controller.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          centerTitle: true,
          actions: [
            GetBuilder<GlobalController>(
              id: 'counter',
              builder: (_) {return _favoritos(_);},
            )
          ],
        ),
        body: GetBuilder<GlobalController>(
          id: 'productos',
          builder: (_) => ListView.builder(
            itemCount: _.productos.length,
            itemBuilder: (ctx, index) {
              final Producto producto = _.productos[index];
              return ListTile(
                title: Text(producto.name),
                subtitle: Text('USD ${producto.price}'),
                trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: producto.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      _.setFavorite(index, !(producto.isFavorite));
                    }),
              );
            },
          ),
        ));
  }

  Widget _favoritos(GlobalController _) {
    return Center(
        child: Container(
          padding: EdgeInsets.only(right: 40),
          child: Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.red),
              SizedBox(width: 10,),
              Text('${_.favoriteCount}'),
            ],
          ),
        ),
      );
  }
}
