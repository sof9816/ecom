import 'package:ecom/clients/api_client/api_client.dart';

abstract class BaseRepo {
  final ApiClient client;
  BaseRepo(this.client);
}
