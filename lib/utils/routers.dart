import 'package:ecom/models/product.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecom/app.dart';
import 'package:ecom/screens/auth/login_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case App.route:
      return MaterialPageRoute(builder: (_) => const App());
    case HomeScreen.route:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case ProductScreen.route:
      return MaterialPageRoute(
          builder: (_) => ProductScreen(
                product: settings.arguments as ProductModel,
              ));
    case LoginScreen.route:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    default:
      return MaterialPageRoute(builder: (_) => LoginScreen());
  }
}
