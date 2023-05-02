import 'package:flutter/material.dart';

TextField customTextField(
  BuildContext context,
  TextEditingController controller,
  TextInputType textInputType,
  bool isObscuredText,
  String hintText,
) =>
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
