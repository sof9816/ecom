import 'package:ecom/blocs/authentication/bloc.dart';
import 'package:ecom/repositories/user_repo.dart';
import 'package:ecom/screens/auth/login_screen.dart';
import 'package:ecom/utils/constants/app_color.dart';
import 'package:ecom/utils/routers.dart';
import 'package:ecom/utils/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';

class App extends StatefulWidget {
  static const route = '/app';
  const App({Key? key}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final AuthenticationBloc _authenticationBloc =
      AuthenticationBloc(userRepo: repo.get<UserRepo>());

  @override
  void initState() {
    _authenticationBloc.add(AppStarted());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => _authenticationBloc,
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColor.shared.grayColor,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          home: BlocBuilder(
            bloc: BlocProvider.of<AuthenticationBloc>(context),
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                // return HomeScreen();
              }

              if (state is AuthenticationUnauthenticated) {
                return LoginScreen();
              }

              if (state is AuthenticationLoading) {
                return const SplashScreen();
              }
              return const SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
