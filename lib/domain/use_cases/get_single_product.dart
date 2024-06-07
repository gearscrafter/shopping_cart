import 'package:dartz/dartz.dart';
import '../../infraestructure/models/product_model.dart';
import '../repositories/product_repository.dart';
import '../../../core/errors/failures.dart';

class GetSingleProduct {
  final ProductsRepository repository;

  GetSingleProduct(this.repository);

  Future<Either<Failure, ProductModel>> call(int productId) async {
    return await repository.getSingleProduct(productId);
  }
}
