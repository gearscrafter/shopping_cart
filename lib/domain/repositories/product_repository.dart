import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../infraestructure/models/product_model.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> getSingleProduct(int productId);
}
