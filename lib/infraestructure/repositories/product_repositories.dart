import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/products_remote_data_source.dart';

class ProductsRepositories implements CartRepository, ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositories(this.remoteDataSource);

  @override
  Future<Either<Failure, CartEntity>> sendProductToCart(CartEntity cart) async {
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
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
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
  Future<Either<Failure, ProductEntity>> getSingleProduct(int productId) async {
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
