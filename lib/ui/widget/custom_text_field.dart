import 'package:flutter/material.dart';

TextField customTextField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType textInputType,
  required bool isObscuredText,
  required String hintText,
}) =>
    TextField(
      style: Theme.of(context).textTheme.bodySmall,
      keyboardType: textInputType,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(hintText: hintText),
      obscureText: isObscuredText,
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
    );
