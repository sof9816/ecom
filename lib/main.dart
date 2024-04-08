import 'package:flutter/material.dart';
import 'package:ecom/app.dart';
import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerClient("https://dummyjson.com/");
  registerRepositories();
  runApp(const App());
}
