import 'package:http/http.dart' as http;
import 'package:shopping_cart/core/network/api_client.dart';

import '../../../core/errors/exceptions.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getSingleProduct(int productId);
  Future<CartModel> sendProductToCart(CartModel cart);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiClient _apiClient;
  ProductsRemoteDataSourceImpl(this._apiClient);
  @override
  Future<List<ProductModel>> getProducts() async {
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
  Future<ProductModel> getSingleProduct(int productId) async {
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
  Future<CartModel> sendProductToCart(CartModel cartData) async {
    try {
      final dynamic data = await _apiClient.post('carts/', cartData.toJson());
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
