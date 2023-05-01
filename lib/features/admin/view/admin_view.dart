import 'package:amazon_clone/features/admin/analytics/analytics_screen.dart';
import 'package:amazon_clone/features/admin/view/widgets/custom_app_bar_admin.dart';
import 'package:flutter/material.dart';

import '../../../core/common/bottom_bar.dart';
import '../posts/view/posts_view.dart';
import 'all-orders/orders_screen.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarAdmin(),
      body: BottomBar(
        paramPages: [
          PostsScreen(),
          AnalyticsScreen(),
          OrdersScreen(),
        ],
      ),
    );
  }
}
