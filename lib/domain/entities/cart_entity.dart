class CartEntity {
  int? id;
  int userId;
  DateTime date;
  List<ProductQuantityEntity> products;

  CartEntity({
    this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
}

class ProductQuantityEntity {
  int productId;
  int quantity;

  ProductQuantityEntity({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
