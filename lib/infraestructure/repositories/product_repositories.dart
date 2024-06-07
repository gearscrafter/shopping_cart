import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/products_remote_data_source.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class ProductsRepositories implements CartRepository, ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositories(this.remoteDataSource);

  @override
  Future<Either<Failure, CartModel>> sendProductToCart(CartModel cart) async {
    try {
      final products = await remoteDataSource.sendProductToCart(cart);
      return Right(products);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure('Error en el servidor'));
      } else if (e is CacheException) {
        return Left(CacheFailure('Error de caché'));
      } else {
        return Left(GeneralFailure('Error inesperado: ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure('Error en el servidor'));
      } else if (e is CacheException) {
        return Left(CacheFailure('Error de caché'));
      } else {
        return Left(GeneralFailure('Error inesperado: ${e.toString()}'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getSingleProduct(int productId) async {
    try {
      final product = await remoteDataSource.getSingleProduct(productId);
      return Right(product);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure('Error en el servidor'));
      } else if (e is CacheException) {
        return Left(CacheFailure('Error de caché'));
      } else {
        return Left(GeneralFailure('Error inesperado: ${e.toString()}'));
      }
    }
  }
}
