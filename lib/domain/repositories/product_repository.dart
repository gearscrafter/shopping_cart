import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> getSingleProduct(int productId);
}
