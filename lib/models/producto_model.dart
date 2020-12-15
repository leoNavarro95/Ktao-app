import 'package:meta/meta.dart' show required;

class Producto {
  final int id;
  final String name, description;
  final double price, rating;

  bool isFavorite = false;

  Producto({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.rating,
  });

  static Producto fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['Product ID'],
      name: json['Name'],
      description: json['Description'],
      price: json['Price'].toDouble(),
      rating: json['Rating Avg'].toDouble(),
    );
  }

  
}
