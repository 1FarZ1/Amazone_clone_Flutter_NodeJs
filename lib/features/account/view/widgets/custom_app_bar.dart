
import 'package:flutter/material.dart';

import '../../../../core/constant/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppConsts.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/amazon_in.png',
              width: 120,
              height: 45,
              color: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined),
                ),
                Icon(
                  Icons.search,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
