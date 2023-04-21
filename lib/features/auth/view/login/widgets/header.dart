import 'package:flutter/material.dart';

import '../../../../../core/constant/constants.dart';
import '../login_view.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.auth,
  });

  final Auth auth;

  @override
  Widget build(BuildContext context) {
    return Text(
      auth == Auth.signup ? "Welcome Back" : "Create Account",
      style: const TextStyle(
        color: AppConsts.textColor,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
