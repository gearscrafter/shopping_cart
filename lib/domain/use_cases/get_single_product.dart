import 'package:dartz/dartz.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
import '../../../core/errors/failures.dart';

class GetSingleProduct {
  final ProductsRepository repository;

  GetSingleProduct(this.repository);

  Future<Either<Failure, ProductEntity>> call(int productId) async {
    return await repository.getSingleProduct(productId);
  }
}
