import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    int? id,
    required super.userId,
    required super.date,
    required List<ProductQuantityModel> super.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((item) => ProductQuantityModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductQuantityModel extends ProductQuantityEntity {
  ProductQuantityModel({
    required super.productId,
    required super.quantity,
  });

  factory ProductQuantityModel.fromJson(Map<String, dynamic> json) {
    return ProductQuantityModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
