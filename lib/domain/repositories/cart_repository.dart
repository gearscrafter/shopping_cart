import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../infraestructure/models/cart_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> sendProductToCart(CartModel cart);
}
