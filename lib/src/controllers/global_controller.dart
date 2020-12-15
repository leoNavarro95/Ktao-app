
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:healthCalc/models/producto_model.dart';

class GlobalController extends GetxController {

  List<Producto> _productos = [];
  List<Producto> get productos => _productos;

  int _favoriteCount = 0;
  int get favoriteCount => _favoriteCount;
  
  @override
  void onInit() {
    super.onInit();

    _loadProducts();

  }

  Future<void> _loadProducts() async {
    //con esto se lee el archivo products.json en forma de String
    final String productsString = await rootBundle.loadString('assets/products.json');

    this._productos = (jsonDecode(productsString) as List).map((e) => Producto.fromJson(e)).toList();

    print('[myCode] Productos cargados: ${this.productos[0].name}');
    update(['productos']);

  }

  setFavorite(int index, bool isFavorite){
    Producto producto = _productos[index];
    producto.isFavorite = isFavorite;
    
    if(isFavorite) this._favoriteCount++;
    else this._favoriteCount--;

    update(['productos', 'counter']);
  }

}