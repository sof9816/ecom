import 'package:ecom/utils/constants/app_color.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColor.shared.grayColor),
          ),
        ),
      );
}
