

import 'package:flutter/material.dart';

import '../../../../../core/constant/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: color ?? AppConsts.secondaryColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? AppConsts.textColor : Colors.black,
        ),
      ),
    );
  }
}
