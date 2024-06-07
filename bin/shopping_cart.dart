import 'package:shopping_cart/application/shopping_cart_application.dart';
import 'package:shopping_cart/infraestructure/models/cart_model.dart';
import 'package:shopping_cart/injection_container.dart' as di;

const int productId = 1;

final cart = CartModel(
  userId: 5,
  date: DateTime.now(),
  products: [
    ProductQuantityModel(productId: 5, quantity: 1),
  ],
);

void main(List<String> arguments) async {
  di.InjectionContainer.instance.init();
  final shoppingCartApp = ShoppingCartApplication(
    di.InjectionContainer.instance.getProducts,
    di.InjectionContainer.instance.getSingleProduct,
    di.InjectionContainer.instance.sendProductToCart,
  );

  await shoppingCartApp.fetchProducts();
  await shoppingCartApp.fetchSingleProduct(productId);
  await shoppingCartApp.sendProductToCart(cart);
}
