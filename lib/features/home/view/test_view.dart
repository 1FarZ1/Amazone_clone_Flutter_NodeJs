import 'package:amazon_clone/core/common/bottom_bar.dart';
import 'package:amazon_clone/features/account/view/account_view.dart';
import 'package:amazon_clone/features/cart/view/cart_view.dart';
import 'package:amazon_clone/features/posts/view/posts_view.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(
      paramPages: [
        HomeView(),
        AccountView(),
        CartView()
      ],
    );
  }
}
