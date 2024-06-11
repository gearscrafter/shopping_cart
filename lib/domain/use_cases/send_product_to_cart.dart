import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class SendProductToCart {
  final CartRepository repository;
  SendProductToCart(this.repository);

  Future<Either<Failure, CartEntity>> call(CartEntity cart) async {
    return await repository.sendProductToCart(cart);
  }
}
