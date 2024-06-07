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
  await fetchProducts();
  await fetchSingleProduct(productId);
  await sendProductToCart(cart);
}

Future<void> fetchProducts() async {
  final getProducts = di.getProducts;

  final result = await getProducts.call();

  result.fold(
    (failure) => print('Error al obtener los productos: ${failure.message}'),
    (products) {
      print('\nObteniendo productos:');
      for (var product in products) {
        print('======= Detalle del producto ======');
        print('''
          ID: ${product.id}
          Título: ${product.title}
          Precio: \$${product.price} 💰
          Descripción: ${product.description}
          Categoría: ${product.category}
          Rating: ${product.rating} ⭐
          Imagen: ${product.image}\n
        ''');
      }
    },
  );
}

Future<void> fetchSingleProduct(int productId) async {
  final getSingleProduct = di.getSingleProduct;

  final result = await getSingleProduct.call(productId);

  result.fold(
    (failure) => print('Error al obtener el producto: ${failure.message}'),
    (product) {
      print('=======================');
      print('\nObtener el producto:');
      print('''
        ID: ${product.id}
        Título: ${product.title}
        Descripción: ${product.description}
        Precio: \$${product.price} 💰
        Categoría: ${product.category}
        Rating: ${product.rating} ⭐
        Imagen: ${product.image}\n
      ''');
    },
  );
}

Future<void> sendProductToCart(CartModel cart) async {
  final sendProduct = di.sendProductToCart;

  final result = await sendProduct.call(cart);

  result.fold(
    (failure) => print(
        'Error al enviar el producto al carrito de compras: ${failure.message}'),
    (cart) {
      print('====================================');
      print('\nProducto enviado exitosamente:  🚀\n');
      print('======= Detalles del carrito ======');
      print('''
        ID: ${cart.id}
        Id del usuario: ${cart.userId}
        Fecha: ${cart.date}
      ''');
      for (var product in cart.products) {
        print('======= Detalle del producto ======');
        print('''
        Id: ${product.productId}
        Cantidad: ${product.quantity}
        ''');
      }
    },
  );
}
