import 'package:flutter/material.dart';

import '../../../../core/constant/constants.dart';

class CustomAppBarAdmin extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        height: 50,
        child: Image.asset("assets/images/amazon_in.png"),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppConsts.appBarGradient,
        ),
      ),
      leadingWidth: 150,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 18.0, bottom: 10),
          child: Text(
            "Admin",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
