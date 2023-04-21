
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constant/constants.dart';
import '../login_view.dart';

class MethodeSelectionSection extends StatelessWidget {
  const MethodeSelectionSection({
    super.key,
    required this.auth,
    required this.ref,
  });

  final Auth auth;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: auth == Auth.signin
              ? AppConsts.backgroundColor
              : AppConsts.greyBackgroundCOlor,
          title: const Text(
            'Login',
            style: TextStyle(
              color: AppConsts.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Radio(
            activeColor: AppConsts.secondaryColor,
            fillColor: MaterialStatePropertyAll(
                AppConsts.secondaryColor.withOpacity(.7)),
            value: Auth.signin,
            groupValue: auth,
            onChanged: (Auth? val) {
              ref.read(authTypeProvider.notifier).state = val!;
            },
          ),
        ),
        ListTile(
          tileColor: auth == Auth.signup
              ? AppConsts.backgroundColor
              : AppConsts.greyBackgroundCOlor,
          title: const Text(
            'Create Account',
            style: TextStyle(
              color: AppConsts.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Radio(
            activeColor: AppConsts.secondaryColor,
            fillColor: MaterialStatePropertyAll(
                AppConsts.secondaryColor.withOpacity(.7)),
            value: Auth.signup,
            groupValue: auth,
            onChanged: (Auth? val) {
              ref.read(authTypeProvider.notifier).state = val!;
            },
          ),
        ),
      ],
    );
  }
}
