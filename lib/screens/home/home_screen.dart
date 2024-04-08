import 'dart:async';
import 'package:ecom/blocs/home/home_bloc.dart';
import 'package:ecom/models/user.dart';
import 'package:ecom/repositories/home_repo.dart';
import 'package:ecom/utils/empty.dart';
import 'package:ecom/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ecom/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/utils/constants/app_color.dart';
import 'package:ecom/utils/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  final HomeBloc bloc;
  HomeScreen({Key? key})
      : bloc = HomeBloc(repository: repo.get<HomeRepo>())
          ..add(const FetchHome()),
        super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> pullRefresh() async {
    widget.bloc.add(const FetchHome());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.shared.grayColor,
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: widget.bloc,
          listener: (context, state) {
            // check if user has valid token or not
            if (!isUserValid) {
              Navigator.pushReplacementNamed(context, App.route);
            }
          },
          builder: (context, state) {
            if (state is ProductsFailed) {
              return Empty.noInternetWithError(state.error, () {
                widget.bloc.add(const FetchHome());
              });
            }
            if (state is ProductsLoaded) {
              var products = state.products;
              return SafeArea(
                child: Container(
                  color: AppColor.shared.grayColor,
                  child: RefreshIndicator(
                    onRefresh: pullRefresh,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          height: 70,
                          child: Row(
                            children: [
                              Text(
                                "Hello ${state.user?.firstName ?? ""}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.shared.greenColor,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: AppColor.shared.smokeWhite,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  state.user?.image ?? "",
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
                            itemBuilder: ((context, index) {
                              var product = products[index];
                              return Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.shared.grayColor600,
                                ),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        product.thumbnail ?? "",
                                        width: 99,
                                        height: 99,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      width: gScreenWidth(context) - 175,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColor.shared.smokeWhite),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            product.description ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: AppColor
                                                    .shared.smokeWhite
                                                    .withOpacity(0.5)),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColor
                                                        .shared.greenColor),
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: AppColor
                                                          .shared.smokeWhite,
                                                    )),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${product.price}\$",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            AppColor.shared
                                                                .smokeWhite,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColor
                                                            .shared.smokeWhite
                                                            .withOpacity(0.8)),
                                                  ),
                                                  Text(
                                                    "${((product.price ?? 0) / (product.discountPercentage ?? 0)).toStringAsFixed(2)}\$",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColor
                                                            .shared.greenColor),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
