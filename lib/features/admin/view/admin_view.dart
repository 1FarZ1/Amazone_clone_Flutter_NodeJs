import 'package:amazon_clone/core/common/bottom_bar.dart';
import 'package:amazon_clone/features/admin/add_product/view/add_product_view.dart';
import 'package:amazon_clone/features/admin/posts/view/posts_view.dart';
import 'package:amazon_clone/features/admin/view/all-orders/orders_screen.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(
      paramPages: [
        AddProductScreen(),
        PostsScreen(),
        OrdersScreen(),
      ],
    );
  }
}
