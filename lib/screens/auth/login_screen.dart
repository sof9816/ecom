import 'package:ecom/blocs/login/bloc.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/repositories/user_repo.dart';
import 'package:ecom/utils/loading_indicator.dart';
import 'package:ecom/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecom/blocs/authentication/bloc.dart';
import 'package:ecom/utils/constants/app_color.dart';
import 'package:ecom/utils/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginBloc bloc;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    bloc = LoginBloc(
        repository: repo.get<UserRepo>(),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    // _usernameController.text = "7716174742";
    // _passwordController.text = "12345678";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.shared.grayColor,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: BlocConsumer<LoginBloc, LoginState>(
            bloc: bloc,
            listener: (context, state) {
              // check if user has valid token or not
              if (!isUserValid && state is AuthenticationFailed) {
                showSnackBar(context, "Wrong pass");
              }
              if (state is LoginFailed) {
                showSnackBar(context, state.error);
              }
              if (!isUserValid && state is AuthenticationUninitialized) {
                showSnackBar(context, "Not Verified");
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(34.0),
                child: ListView(
                  children: [
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 29,
                        color: AppColor.shared.greenColor,
                      ),
                    ),
                    const SizedBox(height: 70),
                    Image.asset(
                      "${gImagePath}login.png",
                    ),
                    const SizedBox(height: 70),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Form(
                            key: _formKey,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Column(
                                children: <Widget>[
                                  _buildUsernameTextField(context),
                                  _buildPasswordTextField(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                        buildLoginButton(context, state),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration commonInputDecoration(
      BuildContext context, String placeholder,
      {bool extraWidget = false}) {
    return InputDecoration(
      isDense: false,
      filled: true,
      contentPadding: const EdgeInsets.all(16),
      fillColor: AppColor.shared.grayColor600,
      labelStyle: TextStyle(
        color: AppColor.shared.smokeWhite,
      ),
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusColor: Theme.of(context).primaryColor,
      hintText: placeholder,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColor.shared.smokeWhite.withOpacity(0.5),
      ),
      hintTextDirection: TextDirection.ltr,
      errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }

  Widget buildLoginButton(BuildContext context, dynamic state) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: AppColor.shared.greenColor),
        height: 54,
        width: gScreenWidth(context) - 50,
        child: TextButton(
          onPressed: () async {
            final FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            if (_formKey.currentState != null) {
              if (_formKey.currentState!.validate()) {
                String username = _usernameController.text;
                String password = _passwordController.text;

                bloc.add(DoLogin(username, password));
              }
            }
          },
          child: (state is LoginLoading)
              ? const LoadingIndicator()
              : Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.shared.smokeWhite,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildUsernameTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Username Not Valid";
          }
          return null;
        },
        style: TextStyle(
          fontSize: 16,
          color: AppColor.shared.smokeWhite,
        ),
        keyboardType: TextInputType.name,
        enableSuggestions: false,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        cursorColor: Theme.of(context).primaryColor,
        controller: _usernameController,
        textDirection: TextDirection.ltr,
        decoration:
            commonInputDecoration(context, "Username", extraWidget: true),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          color: AppColor.shared.smokeWhite,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password Not Valid";
          }
          return null;
        },
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        enableSuggestions: false,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        cursorColor: Theme.of(context).primaryColor,
        controller: _passwordController,
        textDirection: TextDirection.ltr,
        decoration: commonInputDecoration(context, "Password"),
      ),
    );
  }
}
