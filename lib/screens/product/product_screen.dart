import 'package:ecom/models/product.dart';
import 'package:ecom/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecom/utils/constants/app_color.dart';

class ProductScreen extends StatefulWidget {
  static const route = '/product';
  final ProductModel product;
  ProductScreen({Key? key, required this.product}) : super(key: key);
  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  late ProductModel product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.shared.grayColor,
        foregroundColor: AppColor.shared.smokeWhite,
      ),
      body: Container(
        color: AppColor.shared.grayColor,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    product.images?.first ?? "",
                    width: gScreenWidth(context) - 16,
                    height: gScreenWidth(context) - 16,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  product.category ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColor.shared.smokeWhite.withOpacity(0.5),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      product.title ?? "",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColor.shared.smokeWhite,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${((product.price ?? 0) / (product.discountPercentage ?? 0)).toStringAsFixed(2)}\$",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.shared.greenColor),
                        ),
                        Text(
                          "${product.price}\$",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColor.shared.smokeWhite,
                              fontWeight: FontWeight.w400,
                              color:
                                  AppColor.shared.smokeWhite.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "${product.description}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.shared.smokeWhite),
                ),
              ],
            ),
            Positioned(
                bottom: 34,
                left: 16,
                right: 16,
                child: buildCartButton(context))
          ],
        ),
      ),
    );
  }

  Widget buildCartButton(BuildContext context) {
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

            //TODO: add to cart
          },
          child: Text(
            "Add To Cart",
            style: TextStyle(
              fontSize: 20,
              color: AppColor.shared.smokeWhite,
            ),
          ),
        ),
      ),
    );
  }
}
