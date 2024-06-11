import 'package:http/http.dart' as http;

import '../../core/errors/exceptions.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductEntity>> getProducts();

  Future<ProductEntity> getSingleProduct(int productId);

  Future<CartEntity> sendProductToCart(CartEntity cart);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient _apiClient;
  ProductsRemoteDataSourceImpl(this._apiClient);
  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final dynamic data = await _apiClient.get('products');
      return (data as List).map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      if (e is http.ClientException) {
        throw GeneralException(message: 'Error de red: ${e.message}');
      } else {
        throw GeneralException(message: 'Error inesperado: ${e.toString()}');
      }
    }
  }

  @override
  Future<ProductEntity> getSingleProduct(int productId) async {
    try {
      final dynamic data = await _apiClient.get('products/$productId');
      return ProductModel.fromJson(data);
    } catch (e) {
      if (e is http.ClientException) {
        throw GeneralException(message: 'Error de red: ${e.message}');
      } else {
        throw GeneralException(message: 'Error inesperado: ${e.toString()}');
      }
    }
  }

  @override
  Future<CartEntity> sendProductToCart(CartEntity cartData) async {
    try {
      final cartProducts = <ProductQuantityModel>[];
      for (var product in cartData.products) {
        cartProducts.add(ProductQuantityModel(
            productId: product.productId, quantity: product.quantity));
      }
      final model = CartModel(
          id: cartData.id,
          userId: cartData.userId,
          date: cartData.date,
          products: cartProducts);
      final dynamic data = await _apiClient.post('carts/', model.toJson());
      return CartModel.fromJson(data);
    } catch (e) {
      if (e is http.ClientException) {
        throw GeneralException(message: 'Error de red: ${e.message}');
      } else {
        throw GeneralException(message: 'Error inesperado: ${e.toString()}');
      }
    }
  }
}
