
import 'package:flutter/material.dart';

import '../../../../../core/constant/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppConsts.secondaryColor.withOpacity(.5),
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: AppConsts.secondaryColor,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}