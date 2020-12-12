
import 'package:dio/dio.dart';
import 'package:preferencias_de_usuario/models/user_model.dart';

class UserAPI {
  UserAPI._internal();//para Singleton
  static UserAPI _instance = UserAPI._internal();
  static UserAPI get instance => _instance;

  final _dio = Dio();

  Future<List<User>> getUsers( int page ) async{
    try{
      final Response response = await this._dio.get("https://reqres.in/api/users", queryParameters:{
        "page": page,
        "delay": 3, //esta es una funcionalidad que tiene reqres.in para simular demoras en las peticiones
      });

      return (response.data['data'] as List).map((e) => User.fromJson(e)).toList();
    }
    catch(e){
      print(e);
      return null;
    }
  }
}