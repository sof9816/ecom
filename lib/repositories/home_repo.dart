import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/clients/api_client/api_errors/app_exception.dart';
import 'package:ecom/clients/home.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/repositories/repo_client/base_repo.dart';

class HomeRepo extends BaseRepo {
  late HomeApi api;

  HomeRepo(ApiClient client) : super(client) {
    api = HomeApi(client);
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      return await api.fetchProducts();
    } on AppException catch (_) {
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
