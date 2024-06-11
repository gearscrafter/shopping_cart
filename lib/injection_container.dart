import 'package:http/http.dart' as http;
import '../core/network/api_client.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../infraestructure/datasources/products_remote_data_source.dart';
import '../infraestructure/repositories/product_repositories.dart';
import 'domain/use_cases/products.dart';

class Container {
  static final Container _instance = Container._internal();

  factory Container() {
    return _instance;
  }

  Container._internal();

  static Container get instance => _instance;

  late ProductsRemoteDataSource _productsRemoteDataSource;
  late ProductsRepository _productsRepository;
  late CartRepository _cartRepository;

  late Products _useCase;

  void init() {
    final apiClient = ApiClient(http.Client());

    _productsRemoteDataSource = ProductsRemoteDataSourceImpl(apiClient);

    _productsRepository = ProductsRepositories(_productsRemoteDataSource);
    _cartRepository = ProductsRepositories(_productsRemoteDataSource);

    _useCase = Products(_productsRepository, _cartRepository);
  }

  Products get usecase => _useCase;
}
