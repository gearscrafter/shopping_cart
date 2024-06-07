import 'package:shopping_cart/domain/repositories/cart_repository.dart';

import 'core/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'domain/repositories/product_repository.dart';
import 'domain/use_cases/get_products.dart';
import 'domain/use_cases/get_single_product.dart';
import 'domain/use_cases/send_product_to_cart.dart';
import 'infraestructure/datasources/products_remote_data_source.dart';
import 'infraestructure/repositories/product_repositories.dart';

final ApiClient apiClient = ApiClient(http.Client());

ProductsRemoteDataSource productRemoteDataSource =
    ProductsRemoteDataSourceImpl(apiClient);

ProductsRepository productRepository =
    ProductsRepositories(productRemoteDataSource);

CartRepository cartRepository = ProductsRepositories(productRemoteDataSource);

GetProducts getProducts = GetProducts(productRepository);

GetSingleProduct getSingleProduct = GetSingleProduct(productRepository);

SendProductToCart sendProductToCart = SendProductToCart(cartRepository);
