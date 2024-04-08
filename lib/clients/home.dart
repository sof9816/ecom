import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/clients/api_client/api_errors/app_exception.dart';
import 'package:ecom/models/product.dart';

const String kProducts = "/products";

class HomeApi {
  final ApiClient client;
  HomeApi(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await client.callRequest(
        Method.get,
        kProducts,
      );

      List<ProductModel> products = List<ProductModel>.from(
        (response["products"] as List).map(
          (e) => ProductModel.fromJson(e),
        ),
      );
      return products;
    } on AppException catch (_) {
      rethrow;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
