import 'package:shopping_cart/application/shopping_cart_application.dart';
import 'package:shopping_cart/infraestructure/models/cart_model.dart';
import 'package:shopping_cart/injection_container.dart' as dependency_injection;

const int productId = 1;

final cart = CartModel(
  userId: 5,
  date: DateTime.now(),
  products: [
    ProductQuantityModel(productId: 5, quantity: 1),
  ],
);

void main(List<String> arguments) async {
  dependency_injection.Container.instance.init();
  final shoppingCartApp = ShoppingCartApplication(
    dependency_injection.Container.instance.usecase,
  );

  await shoppingCartApp.fetchProducts();
  await shoppingCartApp.fetchSingleProduct(productId);
  await shoppingCartApp.sendProductToCart(cart);
}
