import '../domain/entities/cart_entity.dart';
import '../domain/entities/product_entity.dart';
import '../domain/use_cases/products.dart';

class ShoppingCartApplication {
  final Products usecase;

  ShoppingCartApplication(this.usecase);

  Future<void> fetchProducts() async {
    final result = await usecase.callProducts();

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
    final result = await usecase.callSingleProduct(productId);

    result.fold(
      (failure) => print('Error al obtener el producto: ${failure.message}'),
      (product) {
        print('\nObtener el producto:');
        _printProductDetails(product);
      },
    );
  }

  Future<void> sendProductToCart(CartEntity cart) async {
    final result = await usecase.callSendProduct(cart);

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
