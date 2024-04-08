import 'package:ecom/blocs/authentication/bloc.dart';
import 'package:ecom/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (state is AuthenticationFailed)
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(AppStarted());
                    },
                  )
                else
                  const LoadingIndicator()
              ],
            );
          },
        ));
  }
}
