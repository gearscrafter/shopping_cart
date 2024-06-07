import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../infraestructure/models/cart_model.dart';
import '../repositories/cart_repository.dart';

class SendProductToCart {
  final CartRepository repository;
  SendProductToCart(this.repository);

  Future<Either<Failure, CartModel>> call(CartModel cart) async {
    return await repository.sendProductToCart(cart);
  }
}
