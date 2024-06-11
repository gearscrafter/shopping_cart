import 'package:shopping_cart/domain/entities/cart_entity.dart';
import 'package:shopping_cart/domain/entities/product_entity.dart';
import 'package:shopping_cart/domain/use_cases/get_products.dart';
import 'package:shopping_cart/domain/use_cases/get_single_product.dart';

import '../domain/use_cases/send_product_to_cart.dart';

class ShoppingCartApplication {
  final SendProductToCart sendProduct;
  final GetProducts getProducts;
  final GetSingleProduct getSingleProduct;

  ShoppingCartApplication(
      this.getProducts, this.getSingleProduct, this.sendProduct);

  Future<void> fetchProducts() async {
    final result = await getProducts();

    result.fold(
      (failure) => print('Error al obtener los productos: ${failure.message}'),
      (products) {
        print('\nObteniendo productos:');
        for (var product in products) {
          _printProductDetails(product);
        }
      },
    );
  }

  Future<void> fetchSingleProduct(int productId) async {
    final result = await getSingleProduct(productId);

    result.fold(
      (failure) => print('Error al obtener el producto: ${failure.message}'),
      (product) {
        print('\nObtener el producto:');
        _printProductDetails(product);
      },
    );
  }

  Future<void> sendProductToCart(CartEntity cart) async {
    final result = await sendProduct(cart);

    result.fold(
      (failure) => print(
          'Error al enviar el producto al carrito de compras: ${failure.message}'),
      (cart) {
        print('\nProducto enviado exitosamente:  🚀\n');
        _printCartDetails(cart);
      },
    );
  }

  static void _printProductDetails(ProductEntity product) {
    print('======= Detalle del producto ======');
    print('ID: ${product.id}');
    print('Título: ${product.title}');
    print('Precio: \$${product.price} 💰');
    print('Descripción: ${product.description}');
    print('Categoría: ${product.category}');
    print('Rating: ${product.rating} ⭐');
    print('Imagen: ${product.image}\n');
  }

  static void _printCartDetails(CartEntity cart) {
    print('======= Detalles del carrito ======');
    print('ID: ${cart.id}');
    print('Id del usuario: ${cart.userId}');
    print('Fecha: ${cart.date}');
    for (var product in cart.products) {
      print('======= Detalle del producto ======');
      print('Id: ${product.productId}');
      print('Cantidad: ${product.quantity}');
    }
  }
}
