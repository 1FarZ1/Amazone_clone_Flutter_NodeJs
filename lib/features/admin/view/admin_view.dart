import 'package:amazon_clone/features/admin/analytics/analytics_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/common/bottom_bar.dart';
import '../add_product/view/add_product_view.dart';
import '../posts/view/posts_view.dart';
import '../all-orders/orders_screen.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomBar(
      paramPages: [
        PostsScreen(),
        AnalyticsScreen(),
        OrdersScreen(),
      ],
    );
  }
}
