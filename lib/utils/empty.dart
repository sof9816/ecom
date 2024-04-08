import 'package:ecom/utils/constants/app_color.dart';
import 'package:flutter/material.dart';

enum EmptyType { custom, noInternet, noContent }

class Empty extends StatelessWidget {
  final IconData? topIcon;
  final String? headline;
  final String subtitle;
  final void Function() retryFunction;
  final EmptyType type;

  const Empty(
      {Key? key,
      this.topIcon = Icons.cloud_off,
      this.headline = "",
      this.subtitle = "",
      required this.retryFunction,
      this.type = EmptyType.custom})
      : super(key: key);

  factory Empty.noInternet(void Function() retry) {
    return Empty(
        topIcon: Icons.cloud_off,
        headline: "internet",
        subtitle: "",
        retryFunction: retry,
        type: EmptyType.noInternet);
  }

  factory Empty.noInternetWithError(String error, void Function() retry) {
    return Empty(
        topIcon: Icons.cloud_off,
        headline: "internet",
        subtitle: error,
        retryFunction: retry,
        type: EmptyType.noInternet);
  }

  factory Empty.noContent(void Function() retry) {
    return Empty(
        topIcon: Icons.folder_open,
        headline: "content",
        subtitle: "",
        retryFunction: retry,
        type: EmptyType.noContent);
  }

  factory Empty.noContentWithText(
      {String headline = "content",
      required String subtitle,
      required void Function() retry}) {
    return Empty(
        topIcon: Icons.folder_open,
        headline: headline,
        subtitle: subtitle,
        retryFunction: retry,
        type: EmptyType.noContent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            topIcon,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            _buildText(context, headline ?? ""),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
          if (retryFunction != null)
            Container(
              width: 200,
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColor.shared.greenColor,
                  ),
                ),
                onPressed: retryFunction,
                child: Text(
                  "Retry",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
              ),
            )
          else
            Container()
        ],
      ),
    );
  }

  String _buildText(BuildContext context, String text) {
    switch (type) {
      case EmptyType.custom:
        return text;
      case EmptyType.noInternet:
        return "something went wrong";
      case EmptyType.noContent:
        return "No Data";
    }
  }
}
