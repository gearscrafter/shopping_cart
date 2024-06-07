import 'package:http/http.dart' as http;
import '../core/network/api_client.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/use_cases/get_products.dart';
import '../domain/use_cases/get_single_product.dart';
import '../domain/use_cases/send_product_to_cart.dart';
import '../infraestructure/datasources/products_remote_data_source.dart';
import '../infraestructure/repositories/product_repositories.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();

  factory InjectionContainer() {
    return _instance;
  }

  InjectionContainer._internal();

  static InjectionContainer get instance => _instance;

  late ProductsRemoteDataSource _productsRemoteDataSource;
  late ProductsRepository _productsRepository;
  late CartRepository _cartRepository;

  late GetProducts _getProducts;
  late GetSingleProduct _getSingleProduct;
  late SendProductToCart _sendProductToCart;

  void init() {
    final apiClient = ApiClient(http.Client());

    _productsRemoteDataSource = ProductsRemoteDataSourceImpl(apiClient);

    _productsRepository = ProductsRepositories(_productsRemoteDataSource);
    _cartRepository = ProductsRepositories(_productsRemoteDataSource);

    _getProducts = GetProducts(_productsRepository);
    _getSingleProduct = GetSingleProduct(_productsRepository);
    _sendProductToCart = SendProductToCart(_cartRepository);
  }

  GetProducts get getProducts => _getProducts;
  GetSingleProduct get getSingleProduct => _getSingleProduct;
  SendProductToCart get sendProductToCart => _sendProductToCart;
}
