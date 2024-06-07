import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../infraestructure/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductsRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<ProductModel>>> call() async {
    return await repository.getProducts();
  }
}
