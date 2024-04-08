import 'package:flutter/material.dart';

bool _isSnackbarActive = false;

showSnackBar(context, message) {
  if (_isSnackbarActive) {
    return;
  }
  _isSnackbarActive = true;
  ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: CustomSnackBar(
            message: message,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      )
      .closed
      .then((value) => {
            _isSnackbarActive = false,
            ScaffoldMessenger.of(context).clearSnackBars(),
          });
}

class CustomSnackBar extends StatelessWidget {
  final String message;
  const CustomSnackBar({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
