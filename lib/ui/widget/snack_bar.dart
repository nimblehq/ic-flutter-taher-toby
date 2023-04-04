import 'package:flutter/material.dart';

const _snackBarDurationInSeconds = 2;

void showSnackBar(BuildContext context, String errorMessage) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: _snackBarDurationInSeconds),
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  });
}
